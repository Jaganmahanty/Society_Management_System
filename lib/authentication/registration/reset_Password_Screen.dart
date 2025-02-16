import 'package:flutter/material.dart';
import 'package:society_management_system/home_screen.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Reset_Password extends StatefulWidget {
  const Reset_Password({super.key});

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home_Sceeen()),
                        );
                      }
                    }),
              ),
            ],
          )),
    );
  }

  EqTextField buildPwdField() {
    return EqTextField(
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
      isObscureText: true,
      controller: _confirmPwdController,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      hintText: strConfirmPasswordInput,
      labelText: "Confirm Password",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Confirm Password can't be empty ";
        }
        return null;
      },
    );
  }
}
