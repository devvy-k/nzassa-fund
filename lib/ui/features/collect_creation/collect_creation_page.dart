import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CollectCreationPage extends StatelessWidget {
  const CollectCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Lancer une collecte',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nom du projet
            _buildLabelWithInfo('Nom du projet'),
            const SizedBox(height: 6),
            _buildInputField('Nom de votre projet', titleController),

            const SizedBox(height: 16),

            /// Description
            _buildLabelWithInfo('Description'),
            const SizedBox(height: 6),
            _buildInputField(
              'Décrivez votre projet',
              descriptionController,
              maxLines: 4,
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
                  child: _buildInputField(
                    'Entrez le montant de votre collecte',
                    amountController,
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
            _buildPdfPicker(),

            const SizedBox(height: 16),

            /// Catégorie & Tags
            Row(
              children: [
                Expanded(child: _buildDropdownPlaceholder('Catégorie')),
                const SizedBox(width: 12),
                Expanded(child: _buildTagPlaceholder('Tags')),
              ],
            ),

            const SizedBox(height: 24),

            /// Boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text('Annuler')),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Soumettre'),
                ),
              ],
            ),
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

  Widget _buildInputField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }

  Widget _buildMediaPicker() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_photo_alternate_outlined, size: 40),
            SizedBox(height: 8),
            Text(
              'JPG / PNG / MP4',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfPicker() {
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.picture_as_pdf, size: 40),
        ),
        const SizedBox(width: 12),
        const Text('PDF', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDropdownPlaceholder(String label) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(label),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _buildTagPlaceholder(String label) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
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
  const _CollectMediaPicker({super.key});

  @override
  State<_CollectMediaPicker> createState() => __CollectMediaPickerState();
}

class __CollectMediaPickerState extends State<_CollectMediaPicker> {
  final List<File> _mediaFiles = [];

  Future<void> _pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4'],
    );

    if (result != null) {
      setState(() {
        _mediaFiles.addAll(
          result.files
              .where((file) => file.path != null)
              .map((file) => File(file.path!)),
        );
      });
    }
  }

  void _removeMedia(int index) {
    setState(() {
      _mediaFiles.removeAt(index);
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
              color: Colors.grey.shade100,
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
        if (_mediaFiles.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _mediaFiles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final file = _mediaFiles[index];
                final isVideo = file.path.toLowerCase().endsWith('.mp4');

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 100,
                        color: Colors.grey.shade300,
                        child:
                            isVideo
                                ? const Center(
                                  child: Icon(Icons.videocam, size: 40),
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
                            color: Colors.white,
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
