import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class MediaPager extends StatefulWidget {
  final List<String> mediaUrls;
  const MediaPager({super.key, required this.mediaUrls});

  @override
  State<MediaPager> createState() => _MediaPagerState();
}

class _MediaPagerState extends State<MediaPager> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Map<int, VideoPlayerController?> _videoControllers = {};
  final Map<int, bool> _isLoading = {};
  final Map<int, String?> _errorMessages = {};

  @override
  void initState() {
    super.initState();
    _initMedia();
  }

  void _initMedia() {
    for (int i = 0; i < widget.mediaUrls.length; i++) {
      if (_isVideo(widget.mediaUrls[i])) {
        _initializeVideo(i, widget.mediaUrls[i]);
      }
    }
  }

  Future<File> _downloadVideoToCache(int index, String url) async {
    final dir = await getTemporaryDirectory();
    final cachedPath = '${dir.path}/cached_video_$index.mp4';
    final file = File(cachedPath);

    if (!await file.exists()) {
      final response = await HttpClient().getUrl(Uri.parse(url));
      final stream = await response.close();
      final bytes = await consolidateHttpClientResponseBytes(stream);
      await file.writeAsBytes(bytes);
    }

    return file;
  }


  Future<void> _initializeVideo(int index, String url) async {
    setState(() {
      _isLoading[index] = true;
      _errorMessages[index] = null;
    });

    try {
      final cachedFile = await _downloadVideoToCache(index, url);
      final controller = VideoPlayerController.file(cachedFile);
      await controller.initialize();

      setState(() {
        _videoControllers[index] = controller;
        _isLoading[index] = false;
      });

      if (index == _currentPage) {
        controller.play();
      }
    } catch (e) {
      debugPrint('Lecture directe échouée, tentative de conversion: $e');
      final cachedFile = File('${(await getTemporaryDirectory()).path}/cached_video_$index.mp4');
      if (await cachedFile.exists()) {
        await _tryConvertedPlayback(index, cachedFile);
      } else {
        setState(() {
          _isLoading[index] = false;
          _errorMessages[index] = 'Échec lecture vidéo';
        });
      }
    }
  }



  Future<void> _tryConvertedPlayback(int index, File cachedFile) async {
    try {
      final dir = await getTemporaryDirectory();
      final outputPath = '${dir.path}/converted_video_$index.mp4';
      final outputFile = File(outputPath);

      if (!await outputFile.exists()) {
        final cmd = '-i "${cachedFile.path}" -vf "scale=720:1280" -r 30 -c:v libx264 -preset ultrafast -profile:v baseline -level 3.0 -pix_fmt yuv420p -c:a aac "$outputPath"';
        final session = await FFmpegKit.execute(cmd);

        final returnCode = await session.getReturnCode();
        if (returnCode?.isValueSuccess() != true) {
          throw Exception('Échec conversion FFmpeg');
        }
      }

      final controller = VideoPlayerController.file(outputFile);
      await controller.initialize();

      setState(() {
        _videoControllers[index] = controller;
        _isLoading[index] = false;
      });

      if (index == _currentPage) {
        controller.play();
      }
    } catch (e) {
      debugPrint('Conversion échouée: $e');
      setState(() {
        _isLoading[index] = false;
        _errorMessages[index] = 'Impossible de lire la vidéo';
        _videoControllers[index] = null;
      });
    }
  }


  @override
  void dispose() {
    for (final controller in _videoControllers.values) {
      controller?.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  bool _isVideo(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    
    final path = uri.path.toLowerCase();
    return path.endsWith('.mp4') || 
           path.endsWith('.mov') || 
           path.endsWith('.avi') ||
           path.contains('video');
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);

    _videoControllers.forEach((i, controller) {
      if (controller == null) return;
      
      if (i == index) {
        controller.play();
      } else {
        controller.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.mediaUrls.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final mediaUrl = widget.mediaUrls[index];

              if (_isVideo(mediaUrl)) {
                if (_isLoading[index] == true) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_errorMessages[index] != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        Text(_errorMessages[index]!),
                      ],
                    ),
                  );
                }

                final controller = _videoControllers[index];
                if (controller != null && controller.value.isInitialized) {
                  return AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(controller),
                        Positioned.fill(
                          child: InkWell(
                            onTap: () {
                              if (controller.value.isPlaying) {
                                controller.pause();
                              } else {
                                controller.play();
                              }
                              setState(() {});
                            },
                            child: controller.value.isPlaying
                                ? const SizedBox()
                                : const Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(child: Text('Video not available'));
              }

              return CachedNetworkImage(
                imageUrl: mediaUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const Text('Image not available'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        widget.mediaUrls.length < 2
            ? const SizedBox.shrink()
            :
        _buildPageIndicator(widget.mediaUrls.length),
      ],
    );
  }

  Widget _buildPageIndicator(int itemCount) {
    const double dotRadius = 4.0;
    const double dotSpacing = 8.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isSelected = index == _currentPage;
        final width = isSelected ? dotRadius * 6 : dotRadius * 2;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: dotSpacing / 2),
          width: width,
          height: dotRadius * 2,
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey : Colors.grey[300],
            borderRadius: BorderRadius.circular(dotRadius),
          ),
        );
      }),
    );
  }
}
