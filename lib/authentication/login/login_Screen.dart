import 'package:flutter/material.dart';
import 'package:society_management_system/authentication/registration/forgot_Password_Screen.dart';
import 'package:society_management_system/authentication/registration/registration_Screen.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/dashboard_Society_Admin.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Image.asset('assets/images/app_Icon.png',
                          height: 280, fit: BoxFit.cover),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(strLoginMsg,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SizedBox(height: 15),
                      loginForm(),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  loginForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildMobileNoField(),
                buildPinField(),

                // Mobile Number Input
                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   // autovalidateMode: AutovalidateMode
                //   //     .onUserInteraction,
                //   // validator: (value) {
                //   //   if (value == null ||
                //   //       value.isEmpty) {
                //   //     return 'Enter parent\'s mobile number';
                //   //   }
                //   //   if (value.isNotEmpty &&
                //   //       value.length != 10) {
                //   //     return "Mobile no should be 10 digit";
                //   //   } else {
                //   //     return null;
                //   //   }
                //   // },
                //   controller: _mobileNoController,
                //   expands: false,
                //   decoration:  InputDecoration(
                //     prefixIcon: Icon(
                //       Icons.phone,
                //       color: primaryColor,
                //     ),
                //     labelText: mobileNumberInput,
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(7))),
                //   ),
                // ),
                //  SizedBox(height: 20),

                // Password PIN Input
                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   // autovalidateMode: AutovalidateMode
                //   //     .onUserInteraction,
                //   // validator: (value) {
                //   //   if (value == null ||
                //   //       value.isEmpty) {
                //   //     return 'Enter pincode number';
                //   //   }
                //   //   if (value.isNotEmpty &&
                //   //       value.length != 6) {
                //   //     return "Pincode should be 6 digit";
                //   //   } else {
                //   //     return null;
                //   //   }
                //   // },
                //   // controller: pincodeController,
                //   expands: false,
                //   decoration:  InputDecoration(
                //     prefixIcon: Icon(
                //       Icons.password,
                //       color: primaryColor,
                //     ),
                //     labelText: passwordInput,
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(7))),
                //   ),
                // ),
                SizedBox(height: 10),
                // Login Button
                Padding(
                  padding: EdgeInsets.all(6),
                  child: EqButton(
                      text: "Login",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    dashboard_Society_Admin(accessCode: 1)),
                            // MaterialPageRoute(builder: (context) => homepage()),
                          );
                        }
                      }),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 45,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: primaryColor,
                //       foregroundColor: Colors.white,
                //       shadowColor: Colors.black,
                //       elevation: 5,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(7),
                //       ),
                //     ),
                //     child:  Text(
                //       "Login",
                //       style: TextStyle(fontSize: 17),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(right: 10, top: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forgot_Password()),
                        );
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      strRegisterMsg,
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registration_Page()),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 17,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
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
}
