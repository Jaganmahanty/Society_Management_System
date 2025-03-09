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

class Reset_Password extends StatefulWidget {
  final String? userType;
  const Reset_Password({super.key, this.userType = ''});

  @override
  State<Reset_Password> createState() => _Reset_PasswordState();
}

class _Reset_PasswordState extends State<Reset_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: resetForm(),
      ),
    );
  }

  resetForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildPwdField(),
              buildConfirmPwdField(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(6),
                child: EqButton(
                    text: "Reset",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        updateData();
                      }
                    }),
              ),
            ],
          )),
    );
  }

  EqTextField buildPwdField() {
    return EqTextField(
      length: 4,
      isObscureText: true,
      controller: _pwdController,
      prefixIcon: Icon(Icons.lock, color: primaryColor),
      hintText: strPasswordInput,
      labelText: "New Password",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "New Password can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildConfirmPwdField() {
    return EqTextField(
      length: 4,
      isObscureText: true,
      controller: _confirmPwdController,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      hintText: strConfirmPasswordInput,
      labelText: "Confirm Password",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Confirm Password can't be empty";
        } else if (value != _pwdController.text) {
          return "Both passwords must be same !";
        }
        return null;
      },
    );
  }

  Future<bool> updateData() async {
    showProgressIndicator(context);

    String strCPin = _confirmPwdController.text;

    String url = "${Globals.domainUrl}/reset_pwd.php";

    var data = {
      'mobile': Globals.mobile,
      'pin': strCPin,
      // 'table': widget.userType,
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
      // Globals.fName = jsonData['user']['fname'];
      // Globals.lName = jsonData['user']['lname'];
      // setSettings("user_mobile", strMobile);
      // setSettings("user_pin", strPin);
      // setSettings("user_fname", jsonData['user']['fname']);
      // setSettings("user_lname", jsonData['user']['lname']);
      showSnakebar(context,
          color: Colors.green, title: jsonData['message'], milliseconds: 2500);
      Navigator.pushReplacement(
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
}
