import 'package:flutter/material.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/authentication/login/login_Screen.dart';

class registration_Page extends StatefulWidget {
  const registration_Page({super.key});

  @override
  State<registration_Page> createState() => _registration_PageState();
}

final TextEditingController mothernameController = TextEditingController();

class _registration_PageState extends State<registration_Page> {
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
                      height: 25,
                    ),

                    // Image asset

                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/images/building_details.png',
                          // width: 150, // Adjust size as needed
                          // height: 150, // Adjust size as needed
                          fit: BoxFit.cover, // Adjust fit as needed
                        )),
                    const SizedBox(
                      height: 40,
                    ),

                    // FirstName Input

                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Last name';
                        } else {
                          return null;
                        }
                      },
                      // controller: fathernameController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_4,
                          color: primaryColor,
                        ),
                        labelText: strFirstNameInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // LastName Input

                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Last name';
                        } else {
                          return null;
                        }
                      },
                      // controller: mothernameController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_4,
                          color: primaryColor,
                        ),
                        labelText: strtLastNameInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    // MobileNo Input

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
                      // controller: mobileno1Controller,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: primaryColor,
                        ),
                        labelText: strMobileNoInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
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
                        labelText: strPwdInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login_Page()),
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
                          "Register",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )))
          ],
        ),
      )),
    );
  }
}
