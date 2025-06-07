import 'dart:io';

import 'package:flutter/material.dart';

class ImagePager extends StatefulWidget {
  final List<File> images; // must be a list of strings (urls images) later
  const ImagePager({super.key, required this.images});

  @override
  State<ImagePager> createState() => _ImagePagerState();
}

class _ImagePagerState extends State<ImagePager> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.images;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 260,
          child: PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(items[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        _buildPageIndicator(items.length),
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