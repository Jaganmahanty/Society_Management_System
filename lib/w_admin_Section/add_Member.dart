import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:society_management_system/s_admin_section/dashboard_Society_Admin.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Add_Member extends StatefulWidget {
  const Add_Member({super.key});

  @override
  State<Add_Member> createState() => _Add_MemberState();
}

class _Add_MemberState extends State<Add_Member> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _adultMemberController = TextEditingController();
  final TextEditingController _childMemberController = TextEditingController();

  bool isEditMode = false;

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
                    addMemberForm(),
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

  addMemberForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildFirstNameField(),
                buildLastNameField(),
                buildMobileNoField(),
                buildAdultMemberField(),
                buildChildMemberField(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Owner type :",style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 5),
                        ToggleSwitch(
                          minWidth: 90.0,
                          totalSwitches: 2,
                          cornerRadius: 20.0,
                          initialLabelIndex: 0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          labels: ['Owner', 'Rent'],
                          icons: [Icons.home, Icons.house],
                          activeBgColors: [
                            [primaryColor],
                            [Colors.red]
                          ],
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
