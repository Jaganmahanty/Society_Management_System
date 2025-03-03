import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/utils/eqImgCompress.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/eqWidget/eqImagePicker.dart';
import 'package:society_management_system/common/eqWidget/eqAlertDialog1.dart';
import 'package:society_management_system/common/eqWidget/eqLoadingDialog.dart';

class Add_Complaint extends StatefulWidget {
  final int tabIndex;
  const Add_Complaint({super.key, required this.tabIndex});

  @override
  State<Add_Complaint> createState() => _Add_ComplaintState();
}

class _Add_ComplaintState extends State<Add_Complaint> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  List<File> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add your complaint",
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildComplaintTitle(),
                  buildComplaintDesc(),
                  buildImagePicker(),
                  const SizedBox(height: 40),
                  EqButton(text: "Add", onPressed: _addComplaint),
                ],
              ),
            ),
          ),
        ),
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
        controller: _DescriptionController,
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

  EqImagePicker buildImagePicker() {
    return EqImagePicker(
      selectedImages: _selectedImages,
      onImagesSelected: (images) async {
        List<File> compressedImages = [];

        for (var image in images) {
          File? compressedImage = await imgCompress.compressImage(image);
          if (compressedImage != null) {
            compressedImages.add(compressedImage);
          }
        }

        setState(() {
          _selectedImages = compressedImages;
        });
      },
    );
  }

  Future<void> _addComplaint() async {
    if (_titleController.text.isEmpty) {
      showEqAlertDialog(
        context,
        title: "Error",
        message: "Title is required!",
      );
      return;
    }

    String addTo = widget.tabIndex == 0 ? "soc" : "wing";
    String type = "comp";

    showEqLoadingDialog(context);

    try {
      var uri = Uri.parse("https://bearpridejewelry.com/insert_action.php");
      var request = http.MultipartRequest("POST", uri);

      // Add text fields
      request.fields["title"] = _titleController.text;
      request.fields["detail"] = _DescriptionController.text.isNotEmpty
          ? _DescriptionController.text
          : "";
      request.fields["addTo"] = addTo;
      request.fields["type"] = type;

      // Compress and add images
      for (var image in _selectedImages) {
        File? compressedImage = await imgCompress.compressImage(image);
        if (compressedImage != null) {
          request.files.add(
            await http.MultipartFile.fromPath("images[]", compressedImage.path),
          );
        }
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      closeEqLoadingDialog(context);

      if (response.statusCode == 200) {
        try {
          var result = jsonDecode(responseData);
          if (result["success"]) {
            showEqAlertDialog(
              context,
              title: "Success",
              message: "Your complaint has been added successfully!",
              onOkPressed: () {
                Navigator.pop(context);
              },
            );
          } else {
            showEqAlertDialog(
              context,
              title: "Error",
              message: result["message"],
            );
          }
        } catch (e) {
          showEqAlertDialog(
            context,
            title: "Error",
            message: "Invalid Server Response.",
          );
        }
      } else {
        showEqAlertDialog(
          context,
          title: "Error",
          message: "Server error, please try again!",
        );
      }
    } catch (e) {
      closeEqLoadingDialog(context);
      showEqAlertDialog(
        context,
        title: "Error",
        message: "Network error, please try again!",
      );
    }
  }
}
