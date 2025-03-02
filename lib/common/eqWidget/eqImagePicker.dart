import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class EqImagePicker extends StatefulWidget {
  final List<File> selectedImages;
  final Function(List<File>) onImagesSelected;
  final bool showGrid;

  const EqImagePicker({
    super.key,
    required this.selectedImages,
    required this.onImagesSelected,
    this.showGrid = true,
  });

  @override
  State<EqImagePicker> createState() => _EqimagepickerState();
}

class _EqimagepickerState extends State<EqImagePicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMultipleImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      List<File> newImages =
          pickedFiles.map((file) => File(file.path)).toList();

      setState(() {
        widget.selectedImages.addAll(newImages);
      });

      widget.onImagesSelected(widget.selectedImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Images (Optional):",
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton.icon(
                onPressed: _pickMultipleImages,
                icon: const Icon(Icons.image, color: Colors.white),
                label:
                    const Text("Select", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (widget.showGrid) _buildImageGridView(),
      ],
    );
  }

  Widget _buildImageGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.selectedImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                widget.selectedImages[index],
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedImages.removeAt(index);
                    widget.onImagesSelected(widget.selectedImages);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
