import 'dart:io';
import 'package:flutter/material.dart';
import 'package:society_management_system/common/eqWidget/eqAlertDialog.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqImagePicker.dart';
import 'package:society_management_system/common/eqWidget/eqLoadingDialog.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      var response = await http.post(
        Uri.parse("https://bearpridejewelry.com/insert_action.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": _titleController.text,
          "detail": _DescriptionController.text.isNotEmpty
              ? _DescriptionController.text
              : "",
          "addTo": addTo,
          "type": type,
        }),
      );

      closeEqLoadingDialog(context);

      if (response.statusCode == 200) {
        try {
          var result = jsonDecode(response.body);
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
            message: "Inavalid Server Response.",
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
        maxLines: 5,
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.description, color: primaryColor),
          hintText: "Enter Complaint Description",
          labelText: "Complaint Description (Optional)",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Eqimagepicker buildImagePicker() {
    return Eqimagepicker(
      selectedImages: _selectedImages,
      onImagesSelected: (images) {
        setState(() {
          _selectedImages = images;
        });
      },
    );
  }
}
