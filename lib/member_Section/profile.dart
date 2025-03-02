import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Profile extends StatefulWidget {
  bool? isMember;
  var mobile;
  Profile({super.key, this.isMember = true, this.mobile = 0});

  @override
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _adultMemberController = TextEditingController();
  final TextEditingController _childMemberController = TextEditingController();

  bool isEditMode = false;
  bool isMemberProfile = false;

  @override
  void initState() {
    if (widget.isMember!) {
      setState(() {
        isMemberProfile = true;
      });
    }
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
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
                    Container(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.height * 27 / 100),
                      color: primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_circle,
                              size: 60, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            strUsername,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    profileForm(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 8, right: 8),
              child: EqButton(
                  text: isEditMode ? "Save" : "Edit Profile",
                  onPressed: () async {
                    if (!isEditMode) {
                      setState(() {
                        isEditMode = true;
                      });
                    } else {
                      if (_formKey.currentState?.validate() ?? false) {
                        await saveUserData();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           dashboard_Society_Admin(accessCode: 1)),
                        // MaterialPageRoute(builder: (context) => homepage()),
                        // );
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  profileForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isEditMode) buildFirstNameField(),
                if (isEditMode) buildLastNameField(),
                buildMobileNoField(),
                if (isMemberProfile) buildAdultMemberField(),
                if (isMemberProfile) buildChildMemberField(),
              ],
            ),
          )),
    );
  }

  EqTextField buildMobileNoField() {
    return EqTextField(
      length: 10,
      enabled: isEditMode,
      controller: _mobileNoController,
      keyboardType: TextInputType.phone,
      hintText: strMobileNoInput,
      labelText: "Mobile No",
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Mobile No can't be empty ";
        } else if (value.trim().length < 10) {
          return "Enter 10 digit Mobile No !! ";
        }
        return null;
      },
    );
  }

  EqTextField buildFirstNameField() {
    return EqTextField(
      controller: _firstNameController,
      hintText: strFirstNameInput,
      prefixIcon: Icon(Icons.person, color: primaryColor),
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
      keyboardType: TextInputType.number,
      prefixIcon: Icon(Icons.person_2, color: primaryColor),
      hintText: strLastNameInput,
      labelText: "Last Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Last Name can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildAdultMemberField() {
    return EqTextField(
      enabled: isEditMode,
      controller: _adultMemberController,
      keyboardType: TextInputType.number,
      prefixIcon: Icon(Icons.people, color: primaryColor),
      hintText: strAdultMemberInput,
      labelText: "Adult Member Count",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "value can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildChildMemberField() {
    return EqTextField(
      enabled: isEditMode,
      controller: _childMemberController,
      keyboardType: TextInputType.number,
      prefixIcon: Icon(Icons.child_care, color: primaryColor),
      hintText: strChildMemberInput,
      labelText: "Child Member Count",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Value can't be empty ";
        }
        return null;
      },
    );
  }

  Future<bool> fetchData() async {
    String api =
        "${Globals.domainUrl}/profile.php?type=fetch_user&mobile=${widget.mobile}";
    print("API : $api");

    var response = await http.get(Uri.parse(api));
    var jsonData = jsonDecode(response.body);
    print('jsonData: $jsonData');
    if (jsonData != null && jsonData['success']) {
      jsonData = jsonData['record'];
      setState(() {
        _mobileNoController.text = jsonData['mobile'].toString();
        _firstNameController.text = jsonData['fname'].toString();
        _lastNameController.text = jsonData['lname'].toString();
        if (widget.isMember!) {
          _adultMemberController.text = jsonData['adult'].toString();
          _childMemberController.text = jsonData['child'].toString();
        }
      });
    }
    return true;
  }

  Future<bool> saveUserData() async {
    showProgressIndicator(context);

    var strMob = _mobileNoController.text.trim();
    var strFName = _firstNameController.text.trim();
    var strLName = _lastNameController.text.trim();
    var strAdult = _adultMemberController.text.trim();
    var strChild = _childMemberController.text.trim();

    String url = "${Globals.domainUrl}/profile.php";

    var data = {
      "o_mobile": widget.mobile,
      "mobile": strMob,
      "fname": strFName,
      "lname": strLName,
      "adult": strAdult,
      "child": strChild
    };

    var body = json.encode(data);
    print(body);
    print(url);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response.body);
    var jsonData = jsonDecode(response.body);
    hideIndicator(context);

    if (jsonData['success']) {
      setSettings("user_mobile", strMob);
      setSettings("user_fname", strFName);
      setSettings("user_lname", strLName);
      Navigator.pop(context);
      Navigator.pop(context, "Profile updated successfully!");
      showSnakebar(context,
          color: Colors.green, title: jsonData['message'], milliseconds: 2500);
    } else if (!jsonData['success']) {
      Navigator.pop(context);
      Navigator.pop(context, "Error while saving ..");
      showSnakebar(context,
          color: Colors.red, title: jsonData['message'], milliseconds: 2500);
    }
    return true;
  }
}
