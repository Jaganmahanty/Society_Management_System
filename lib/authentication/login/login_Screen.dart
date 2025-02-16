import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/home_screen.dart';
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/authentication/registration/registration_Screen.dart';
import 'package:society_management_system/authentication/registration/forgot_Password_Screen.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  var user_Mobile;
  var user_FName;
  var user_LName;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

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
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: EqButton(
                      text: "Login",
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await saveData();
                        }
                      }),
                ),
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

  Future<bool> saveData() async {
    showProgressIndicator(context);

    String strMobile = _mobileNoController.text;
    String strPin = _pinController.text;

    String url = "${Globals.domainUrl}/user_login.php";

    var data = {'mobile': strMobile, 'pin': strPin};

    var body = json.encode(data);
    print(url);
    print(body);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    hideIndicator(context);

    if (jsonData['success']) {
      Globals.fName = jsonData['user']['fname'];
      Globals.lName = jsonData['user']['lname'];
      setSettings("user_mobile", strMobile);
      setSettings("user_pin", strPin);
      setSettings("user_fname", jsonData['user']['fname']);
      setSettings("user_lname", jsonData['user']['lname']);
      showSnakebar(context,
          color: Colors.green, title: jsonData['message'], milliseconds: 2500);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home_Sceeen()));
    } else if (jsonData['success'] == false) {
      showSnakebar(context,
          color: Colors.red, title: jsonData['message'], milliseconds: 2500);
    } else {
      showSnakebar(context,
          color: Colors.red, title: jsonData['message'], milliseconds: 2500);
    }
    return true;
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

  Future<void> getUserInfo() async {
    user_Mobile = await getSettings("user_mobile");
    print('user_Mobile: $user_Mobile');
    if (user_Mobile.isNotEmpty) {
      user_FName = await getSettings("user_fname");
      user_LName = await getSettings("user_lname");
      print('user_FName: $user_FName');
      print('user_LName: $user_LName');
      Globals.mobile = user_Mobile;
      Globals.fName = user_FName;
      Globals.lName = user_LName;
      if (user_Mobile.isNotEmpty ||
          user_FName.isNotEmpty ||
          user_LName.isNotEmpty) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home_Sceeen(userExists: true)));
      }
    }
  }
}
