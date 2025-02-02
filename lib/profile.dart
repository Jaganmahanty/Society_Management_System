import 'package:flutter/material.dart';
import 'package:society_management_system/dashboard_Society_Admin.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Profile extends StatefulWidget {
  bool? isMember;
  Profile({super.key, this.isMember = true});

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
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
                      height: (MediaQuery.of(context).size.height * 30 / 100),
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
                  onPressed: () {
                    if (!isEditMode) {
                      setState(() {
                        isEditMode = true;
                      });
                    } else {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  dashboard_Society_Admin(accessCode: 1)),
                          // MaterialPageRoute(builder: (context) => homepage()),
                        );
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
      hintText: strtLastNameInput,
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
}
