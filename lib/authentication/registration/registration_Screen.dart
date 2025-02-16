import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/authentication/login/login_Screen.dart';

class registration_Page extends StatefulWidget {
  const registration_Page({super.key});

  @override
  State<registration_Page> createState() => _registration_PageState();
}

class _registration_PageState extends State<registration_Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: const Text(
          registrationAppbar,
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
                      SizedBox(height: 45),
                      Image.asset('assets/images/building_details.png',
                          height: 200, fit: BoxFit.cover),
                      SizedBox(height: 20),
                      regForm(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: EqButton(
                  text: "Register",
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

  regForm() {
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
              buildPinField(),
            ],
          ),
        ));
  }

  Future<bool> saveData() async {
    showProgressIndicator(context);

    var id = 0;
    // id = widget.xId;
    String strFName = _firstNameController.text;
    String strLName = _lastNameController.text;
    String strMobile = _mobileNoController.text;
    String strPin = _pinController.text;

    String url = "${Globals.domainUrl}/user_reg.php?id=$id";

    var data = {
      'fname': strFName,
      'lname': strLName,
      'mobile': strMobile,
      'pin': strPin
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login_Page()));
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

  EqTextField buildPinField() {
    return EqTextField(
      length: 4,
      isObscureText: true,
      controller: _pinController,
      keyboardType: TextInputType.number,
      prefixIcon: Icon(Icons.password, color: primaryColor),
      hintText: strPwdInput,
      labelText: "4 Digit PIN",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "PIN can't be empty ";
        }
        return null;
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       backgroundColor: appbarColor,
  //       title: const Text(
  //         registrationAppbar,
  //         style: TextStyle(color: appbarTextColor),
  //       ),
  //     ),
  //     body: Form(
  //         child: SizedBox(
  //       width: double.infinity,
  //       child: Column(
  //         children: [
  //           Expanded(
  //               child: Scrollbar(
  //                   child: SingleChildScrollView(
  //             child: Padding(
  //               padding: const EdgeInsets.all(24),
  //               child: Column(
  //                 children: [
  //                   const SizedBox(
  //                     height: 25,
  //                   ),

  //                   // Image asset

  //                   SizedBox(
  //                       height: 200,
  //                       width: 200,
  //                       child: Image.asset(
  //                         'assets/images/building_details.png',
  //                         // width: 150, // Adjust size as needed
  //                         // height: 150, // Adjust size as needed
  //                         fit: BoxFit.cover, // Adjust fit as needed
  //                       )),
  //                   const SizedBox(
  //                     height: 40,
  //                   ),

  //                   // FirstName Input

  //                   TextFormField(
  //                     autovalidateMode: AutovalidateMode.onUserInteraction,
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Enter Last name';
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                     // controller: fathernameController,
  //                     expands: false,
  //                     decoration: const InputDecoration(
  //                       prefixIcon: Icon(
  //                         Icons.person_4,
  //                         color: primaryColor,
  //                       ),
  //                       labelText: strFirstNameInput,
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(7))),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 25),

  //                   // LastName Input

  //                   TextFormField(
  //                     autovalidateMode: AutovalidateMode.onUserInteraction,
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Enter Last name';
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                     // controller: mothernameController,
  //                     expands: false,
  //                     decoration: const InputDecoration(
  //                       prefixIcon: Icon(
  //                         Icons.person_4,
  //                         color: primaryColor,
  //                       ),
  //                       labelText: strLastNameInput,
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(7))),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 25,
  //                   ),

  //                   // MobileNo Input

  //                   TextFormField(
  //                     keyboardType: TextInputType.phone,
  //                     // autovalidateMode: AutovalidateMode
  //                     //     .onUserInteraction,
  //                     // validator: (value) {
  //                     //   if (value == null ||
  //                     //       value.isEmpty) {
  //                     //     return 'Enter parent\'s mobile number';
  //                     //   }
  //                     //   if (value.isNotEmpty &&
  //                     //       value.length != 10) {
  //                     //     return "Mobile no should be 10 digit";
  //                     //   } else {
  //                     //     return null;
  //                     //   }
  //                     // },
  //                     // controller: mobileno1Controller,
  //                     expands: false,
  //                     decoration: const InputDecoration(
  //                       prefixIcon: Icon(
  //                         Icons.phone,
  //                         color: primaryColor,
  //                       ),
  //                       labelText: strMobileNoInput,
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(7))),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),

  //                   // Password PIN Input

  //                   TextFormField(
  //                     keyboardType: TextInputType.phone,
  //                     // autovalidateMode: AutovalidateMode
  //                     //     .onUserInteraction,
  //                     // validator: (value) {
  //                     //   if (value == null ||
  //                     //       value.isEmpty) {
  //                     //     return 'Enter pincode number';
  //                     //   }
  //                     //   if (value.isNotEmpty &&
  //                     //       value.length != 6) {
  //                     //     return "Pincode should be 6 digit";
  //                     //   } else {
  //                     //     return null;
  //                     //   }
  //                     // },
  //                     // controller: pincodeController,
  //                     expands: false,
  //                     decoration: const InputDecoration(
  //                       prefixIcon: Icon(
  //                         Icons.password,
  //                         color: primaryColor,
  //                       ),
  //                       labelText: strPwdInput,
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(7))),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 50,
  //                   ),
  //                   SizedBox(
  //                     width: double.infinity,
  //                     height: 45,
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => const Login_Page()),
  //                         );
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: primaryColor,
  //                         foregroundColor: Colors.white,
  //                         // Text color
  //                         shadowColor: Colors.black, // Shadow color
  //                         elevation: 5, // Elevation of the button
  //                         shape: RoundedRectangleBorder(
  //                           // Shape of the button
  //                           borderRadius:
  //                               BorderRadius.circular(7), // Rounded corners
  //                         ),
  //                         // Padding inside button
  //                       ),
  //                       child: const Text(
  //                         "Register",
  //                         style: TextStyle(fontSize: 17),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )))
  //         ],
  //       ),
  //     )),
  //   );
  // }
}
