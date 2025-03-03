import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/utils/eqImgCompress.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/eqWidget/eqImagePicker.dart';
import 'package:society_management_system/common/eqWidget/eqBottomNavigationBarButton.dart';

class Update_Complaint extends StatefulWidget {
  final String complaintId;
  const Update_Complaint({super.key, required this.complaintId});

  @override
  State<Update_Complaint> createState() => _Update_ComplaintState();
}

class _Update_ComplaintState extends State<Update_Complaint> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> existingImageUrls = [];
  List<File> selectedImages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchComplaintDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Complaint",
          style: const TextStyle(color: appbarTextColor),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    buildComplaintTitle(),
                    buildComplaintDesc(),
                    EqImagePicker(
                      selectedImages: selectedImages,
                      showGrid: false,
                      onImagesSelected: (List<File> images) {
                        setState(() {
                          selectedImages = images;
                        });
                      },
                    ),
                    if (existingImageUrls.isNotEmpty ||
                        selectedImages.isNotEmpty)
                      buildImageGridView(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: EqBottomButton(
        onPress: _updateComplaint,
        buttonText: "Update Complaint",
      ),
    );
  }

  EqTextField buildComplaintTitle() {
    return EqTextField(
      controller: _titleController,
      prefixIcon: Icon(Icons.title, color: primaryColor),
      hintText: "Enter complaint title",
      labelText: "Complaint Title",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Add Complaint Title";
        }
        return null;
      },
    );
  }

  Padding buildComplaintDesc() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 10,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.description, color: primaryColor),
          hintText: "Enter Complaint Description",
          labelText: "Complaint Description (Optional)",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _fetchComplaintDetails() async {
    try {
      var url =
          "https://bearpridejewelry.com/fetch_action.php?id=${widget.complaintId}";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["success"] == true &&
            jsonResponse["data"] is List &&
            jsonResponse["data"].isNotEmpty) {
          var complaint = jsonResponse["data"][0];

          if (mounted) {
            setState(() {
              _titleController.text = complaint["title"];
              _descriptionController.text = complaint["detail"] ?? "";
              existingImageUrls = complaint["img"] != null
                  ? List<String>.from(complaint["img"])
                  : [];
              isLoading = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          eqToast("Failed to fetch complaint details");
        }
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        eqToast("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching details: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      eqToast("Network error, please try again.");
    }
  }

  void _removeImage(dynamic image) {
    setState(() {
      if (image is String) {
        existingImageUrls.remove(image);
      } else if (image is File) {
        selectedImages.removeWhere((file) => file.path == image.path);
      }
    });
  }

  Future<void> _updateComplaint() async {
    if (_titleController.text.isEmpty) {
      eqToast("Title is required");
      return;
    }

    List<File> compressedImages = [];
    for (File image in selectedImages) {
      File? compressedImage = await imgCompress.compressImage(image);
      if (compressedImage != null) {
        compressedImages.add(compressedImage);
      }
    }

    var uri = Uri.parse("https://bearpridejewelry.com/update_action.php");
    var request = http.MultipartRequest("POST", uri);

    request.fields["id"] = widget.complaintId;
    request.fields["title"] = _titleController.text;
    request.fields["detail"] = _descriptionController.text;

    request.fields["existing_images"] = jsonEncode(existingImageUrls);

    for (File image in compressedImages) {
      request.files
          .add(await http.MultipartFile.fromPath("images[]", image.path));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseData);

    debugPrint("Update Response: $jsonResponse");

    if (jsonResponse["status"] == "success") {
      eqToast("Complaint updated successfully");

      if (jsonResponse.containsKey("images")) {
        setState(() {
          existingImageUrls = List<String>.from(jsonResponse["images"]);
        });
      }

      Navigator.pop(context, true);
    } else {
      eqToast("Update failed: ${jsonResponse["message"]}");
    }
  }

  Widget buildImageGridView() {
    List<dynamic> allImages = [...existingImageUrls, ...selectedImages];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: allImages.length,
      itemBuilder: (context, index) {
        final image = allImages[index];
        final isFile = image is File;

        return Stack(
          children: [
            isFile
                ? Image.file(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (ctx, error, stack) =>
                        Icon(Icons.broken_image),
                  ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => _removeImage(image),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
