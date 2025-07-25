import 'dart:developer' as console;
import 'dart:io';
import 'package:crowfunding_project/core/constants/nav_ids.dart';
import 'package:crowfunding_project/core/constants/project_categories.dart';
import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/domain/entities/project.dart';
import 'package:crowfunding_project/ui/features/collect_creation/collect_creation_viewmodel.dart';
import 'package:crowfunding_project/utils/custom_textformfield.dart';
import 'package:crowfunding_project/utils/receipt_picker.dart';
import 'package:crowfunding_project/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CollectCreationPage extends StatefulWidget {
  const CollectCreationPage({super.key});

  @override
  State<CollectCreationPage> createState() => _CollectCreationPageState();
}

class _CollectCreationPageState extends State<CollectCreationPage> {
  final CollectCreationViewmodel collectCreationViewmodel =
      Get.find<CollectCreationViewmodel>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  ProjectCategories? selectedCategory;

  bool _isLoading = false;
  Project? project;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    project = ProjectModel(
      id: Utils.generateId(),
      title: titleController.text,
      content: descriptionController.text,
      author: Get.find<SessionManager>().user!.toAuthor(),
      images: [], // replace with actual images
      createdAt: DateTime.now(),
      totalCollected: 0,
      collectGoal: int.tryParse(amountController.text) ?? 0,
      likes: [],
      comments: [],
      category: selectedCategory!.name,
      tags: [], // replace with selected tags
      receipts: [],
    );
  
      Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });

    Get.toNamed('/collect-preview', arguments: project, id: NavIds.collectCreation);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lancer une collecte',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Nom du projet
                  _buildLabelWithInfo('Nom du projet'),
                  const SizedBox(height: 6),
                  CustomTextformfield(
                    hint: 'Entrez le nom de votre projet',
                    controller: titleController,
                    contentRequired: true,
                    keyBoardType: 'text',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ce champ est réquis';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Description
                  _buildLabelWithInfo('Description'),
                  const SizedBox(height: 6),
                  CustomTextformfield(
                    hint: 'Entrez une description de votre projet',
                    controller: descriptionController,
                    contentRequired: true,
                    keyBoardType: 'text',
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ce champ est réquis';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Photos
                  _buildLabelWithInfo('Médias'),
                  const SizedBox(height: 6),
                  _CollectMediaPicker(),

                  const SizedBox(height: 16),

                  /// Montant de la collecte
                  const Text(
                    'Montant de la collecte',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextformfield(
                          hint: 'Entrez le montant',
                          controller: amountController,
                          contentRequired: true,
                          keyBoardType: 'number',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ce champ est réquis';
                            }
                            final amount = int.tryParse(value);
                            if (amount == null || amount <= 0) {
                              return 'Veuillez entrer un montant valide';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'FCFA',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Justificatifs
                  _buildLabelWithInfo('Justificatifs'),
                  const SizedBox(height: 6),
                  ReceiptPicker(),

                  const SizedBox(height: 16),

                  /// Catégorie & Tags
                  Row(
                    children: [
                      Expanded(child: _buildCategoriesDropdown('Catégorie')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTagPlaceholder('Tags')),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Boutons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Annuler'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Prévisualiser'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelWithInfo(String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 4),
        const Icon(Icons.info_outline, size: 16),
      ],
    );
  }

  Widget _buildCategoriesDropdown(String label) {
    return DropdownButtonFormField<ProjectCategories>(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      ),
      value: selectedCategory,
      hint: const Text('Catégorie', style: TextStyle(fontSize: 13)),
      items:
          ProjectCategories.values.map((category) {
            return DropdownMenuItem<ProjectCategories>(
              value: category,
              child: Text(category.label),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Sélectionnez une catégorie';
        }
        return null;
      },
    );
  }

  Widget _buildTagPlaceholder(String label) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [Text(label), const Spacer(), const Icon(Icons.add)],
        ),
      ),
    );
  }
}

class _CollectMediaPicker extends StatefulWidget {
  const _CollectMediaPicker();

  @override
  State<_CollectMediaPicker> createState() => __CollectMediaPickerState();
}

class __CollectMediaPickerState extends State<_CollectMediaPicker> {
  final CollectCreationViewmodel collectCreationViewmodel =
      Get.find<CollectCreationViewmodel>();
  final Map<String, VideoPlayerController> _videoControllers = {};

  @override
  void dispose() {
    for (var controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4'],
    );

    if (result != null) {
      for (var file in result.files) {
        if (file.path != null) {
          final newFile = File(file.path!);
          collectCreationViewmodel.mediaFiles.add(newFile);

          if (newFile.path.toLowerCase().endsWith('.mp4')) {
            try {
              final controller = VideoPlayerController.file(newFile);
              await controller.initialize();
              controller.setLooping(false);
              controller.setVolume(0.7);
              _videoControllers[newFile.path] = controller;
            } catch (e) {
              // Optionally show a snackbar or log the error
              console.log('Error initializing video player: $e');
            }
          }
        }
      }
      setState(() {});
    }
  }

  void _removeMedia(int index) {
    final file = collectCreationViewmodel.mediaFiles[index];
    final path = file.path;

    if (_videoControllers.containsKey(path)) {
      _videoControllers[path]?.dispose();
      _videoControllers.remove(path);
    }

    setState(() {
      collectCreationViewmodel.mediaFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _pickMedia,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_photo_alternate_outlined, size: 40),
                  SizedBox(height: 8),
                  Text(
                    'Ajouter médias (JPG / PNG / MP4)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (collectCreationViewmodel.mediaFiles.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: collectCreationViewmodel.mediaFiles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final file = collectCreationViewmodel.mediaFiles[index];
                final isVideo = file.path.toLowerCase().endsWith('.mp4');

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 100,
                        height: 100,
                        child:
                            isVideo
                                ? _videoControllers[file.path] != null
                                    ? GestureDetector(
                                      onTap: () {
                                        final controller =
                                            _videoControllers[file.path]!;
                                        if (controller.value.isPlaying) {
                                          controller.pause();
                                        } else {
                                          controller.play();
                                        }
                                        setState(() {});
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AspectRatio(
                                            aspectRatio:
                                                _videoControllers[file.path]!
                                                    .value
                                                    .aspectRatio,
                                            child: VideoPlayer(
                                              _videoControllers[file.path]!,
                                            ),
                                          ),
                                          if (!_videoControllers[file.path]!
                                              .value
                                              .isPlaying)
                                            const Icon(
                                              Icons.play_circle_fill,
                                              size: 50,
                                            ),
                                        ],
                                      ),
                                    )
                                    : const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                : Image.file(file, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () => _removeMedia(index),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
