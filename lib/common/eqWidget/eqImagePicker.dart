import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class Eqimagepicker extends StatefulWidget {
  final List<File> selectedImages; // Image list to store selected images
  final Function(List<File>) onImagesSelected; // Callback function

  const Eqimagepicker({
    Key? key,
    required this.selectedImages,
    required this.onImagesSelected,
  }) : super(key: key);

  @override
  State<Eqimagepicker> createState() => _EqimagepickerState();
}

class _EqimagepickerState extends State<Eqimagepicker> {
  final ImagePicker _picker = ImagePicker();

  // Function to pick multiple images
  Future<void> _pickMultipleImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      List<File> newImages =
          pickedFiles.map((file) => File(file.path)).toList();

      setState(() {
        widget.selectedImages.addAll(newImages);
      });

      widget.onImagesSelected(widget.selectedImages); // Notify parent
    }
  }

  // Function to remove an image
  void _removeImage(int index) {
    setState(() {
      widget.selectedImages.removeAt(index);
    });

    widget.onImagesSelected(widget.selectedImages); // Notify parent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row with title and select button
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

        // Display selected images in GridView
        widget.selectedImages.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: widget.selectedImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      // Display selected image
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            widget.selectedImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Remove button
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close,
                                size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : const Text("No images selected"),
      ],
    );
  }
}
