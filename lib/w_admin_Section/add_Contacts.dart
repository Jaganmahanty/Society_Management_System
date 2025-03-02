import 'package:flutter/material.dart';
import 'package:society_management_system/s_admin_section/dashboard_Society_Admin.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Add_Contacts extends StatefulWidget {
  const Add_Contacts({super.key});

  @override
  State<Add_Contacts> createState() => _Add_ContactsState();
}

class _Add_ContactsState extends State<Add_Contacts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add",
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    addContactForm(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 8, right: 8),
              child: EqButton(
                  text: "Save",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                dashboard_Society_Admin(accessCode: 1)),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  addContactForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildNameField(),
                buildDescField(),
                buildMobileNoField(),
              ],
            ),
          )),
    );
  }

  EqTextField buildMobileNoField() {
    return EqTextField(
      length: 10,
      controller: _mobileNoController,
      keyboardType: TextInputType.phone,
      hintText: strMobileNoInput,
      labelText: "Mobile No",
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Mobile No can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildNameField() {
    return EqTextField(
      controller: _nameController,
      hintText: "Enetr First Name",
      prefixIcon: Icon(Icons.person, color: primaryColor),
      labelText: "First Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "First can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildDescField() {
    return EqTextField(
      controller: _descController,
      prefixIcon: Icon(Icons.description, color: primaryColor),
      hintText: "Enter Description",
      labelText: "Description",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Description can't be empty ";
        }
        return null;
      },
    );
  }
}
