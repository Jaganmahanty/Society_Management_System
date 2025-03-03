import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/common/eqWidget/eqDropdownField.dart';

class add_Wing_Admin extends StatefulWidget {
  const add_Wing_Admin({super.key});

  @override
  State<add_Wing_Admin> createState() => _add_Wing_AdminState();
}

class _add_Wing_AdminState extends State<add_Wing_Admin> {
  @override
  void initState() {
    super.initState();
    getWings();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();

  String dropdownWings = '';
  var wingsItemsMap = {'': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: const Text(
          "Fill Up Details",
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      addAdminForm(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: EqButton(
                  text: "Give Admin Previlege",
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await saveData();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  addAdminForm() {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildFirstNameField(),
              buildLastNameField(),
              buildMobileNoField(),
              buildWingField()
            ],
          ),
        ));
  }

  Future<bool> saveData() async {
    showProgressIndicator(context);

    var id = 0;

    String strFName = _firstNameController.text;
    String strLName = _lastNameController.text;
    String strMobile = _mobileNoController.text;
    String strWing = dropdownWings;

    String url = "${Globals.domainUrl}/addw_admin.php?id=$id";

    var data = {
      'fname': strFName,
      'lname': strLName,
      'mobile': strMobile,
      'pin': "2424",
      'wing': strWing
    };

    var body = json.encode(data);
    print(url);
    print(body);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    hideIndicator(context);

    if (jsonData['success']) {
      showSnakebar(context,
          color: Colors.green, title: jsonData['message'], milliseconds: 2500);
      Navigator.pop(context, true);
    } else if (jsonData['success'] == false) {
      showSnakebar(context,
          color: Colors.red, title: jsonData['message'], milliseconds: 2500);
    } else {
      showSnakebar(context,
          color: Colors.red, title: jsonData['message'], milliseconds: 2500);
    }
    return true;
  }

  EqTextField buildFirstNameField() {
    return EqTextField(
      controller: _firstNameController,
      prefixIcon: Icon(Icons.person, color: primaryColor),
      hintText: strMobileNoInput,
      labelText: "First Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "First Name can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildLastNameField() {
    return EqTextField(
      controller: _lastNameController,
      prefixIcon: Icon(Icons.person_2, color: primaryColor),
      hintText: strMobileNoInput,
      labelText: "Last Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Last Name can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildMobileNoField() {
    return EqTextField(
      length: 10,
      controller: _mobileNoController,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      hintText: strMobileNoInput,
      labelText: "Mobile No",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Mobile No can't be empty ";
        }
        return null;
      },
    );
  }

  eqDropdownField buildWingField() {
    return eqDropdownField(
        enabled: true,
        labelText: 'Select Wing',
        hintText: 'Select Wing',
        value: dropdownWings,
        items: wingsItemsMap,
        onChanged: (String? newValue) {
          if (newValue != null) {
            String selectedKey = wingsItemsMap.entries
                .firstWhere((entry) => entry.value == newValue)
                .key;
            dropdownWings = newValue;
            print('Selected Key : $selectedKey');
            print('Selected Value : $newValue');
          }
        });
  }

  Future<void> getWings() async {
    String api = "${Globals.domainUrl}/getwings.php?code=${Globals.accesscode}";
    print("API : $api");

    var response = await http.get(Uri.parse(api));
    var jsonData = jsonDecode(response.body);
    print('jsonData: $jsonData');
    if (jsonData != null && jsonData['success']) {
      if (jsonData['success']) {
        setState(() {
          dropdownWings = jsonData['wings'][0];
          wingsItemsMap = {for (var wing in jsonData['wings']) wing: wing};
        });
      }
    }
  }
}
