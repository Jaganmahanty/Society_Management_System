import 'package:flutter/material.dart';
import 'package:society_management_system/forgot_Password_Screen.dart';
import 'package:society_management_system/global_Declaration/colors.dart';
import 'package:society_management_system/global_Declaration/strings.dart';
import 'package:society_management_system/homepage.dart';
import 'package:society_management_system/registration_Screen.dart';

// ignore: camel_case_types
class login_Page extends StatefulWidget {
  const login_Page({super.key});

  @override
  State<login_Page> createState() => _login_PageState();
}

// ignore: camel_case_types
class _login_PageState extends State<login_Page> {
  final TextEditingController _mobileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Scrollbar(
                    child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),

                      // Image asset

                      SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/app_Icon.png',
                            // width: 150, // Adjust size as needed
                            // height: 150, // Adjust size as needed
                            fit: BoxFit.cover, // Adjust fit as needed
                          )),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment
                              .centerLeft, // This ensures the text aligns to the left
                          child: Text(
                            loginMsg,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Mobile Number Input

                      TextFormField(
                        keyboardType: TextInputType.phone,
                        // autovalidateMode: AutovalidateMode
                        //     .onUserInteraction,
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty) {
                        //     return 'Enter parent\'s mobile number';
                        //   }
                        //   if (value.isNotEmpty &&
                        //       value.length != 10) {
                        //     return "Mobile no should be 10 digit";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        controller: _mobileNoController,
                        expands: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: primaryColor,
                          ),
                          labelText: mobileNumberInput,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Password PIN Input

                      TextFormField(
                        keyboardType: TextInputType.phone,
                        // autovalidateMode: AutovalidateMode
                        //     .onUserInteraction,
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty) {
                        //     return 'Enter pincode number';
                        //   }
                        //   if (value.isNotEmpty &&
                        //       value.length != 6) {
                        //     return "Pincode should be 6 digit";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        // controller: pincodeController,
                        expands: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: primaryColor,
                          ),
                          labelText: passwordInput,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      // Login Button

                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const homepage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            // Text color
                            shadowColor: Colors.black, // Shadow color
                            elevation: 5, // Elevation of the button
                            shape: RoundedRectangleBorder(
                              // Shape of the button
                              borderRadius:
                                  BorderRadius.circular(7), // Rounded corners
                            ),
                            // Padding inside button
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),

                      // Forgot Password TextButton

                      GestureDetector(
                        onTap: () {
                          String number = _mobileNoController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    forgot_Password(number: number)),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10.0, top: 15),
                          child: Align(
                            alignment: Alignment
                                .centerRight, // This ensures the text aligns to the left
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: primaryColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Register Message

                          const Align(
                            alignment: Alignment
                                .centerLeft, // This ensures the text aligns to the left
                            child: Text(
                              registerMsg,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          // Register TextButton

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const registration_Page()),
                              );
                            },
                            child: const Align(
                              alignment: Alignment
                                  .centerLeft, // This ensures the text aligns to the left
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: primaryColor),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            )))
          ],
        ),
      )),
    );
  }
}
