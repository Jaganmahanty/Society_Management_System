import 'package:flutter/material.dart';
import 'package:society_management_system/authentication/registration/otp_Screen.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mobileNoController.dispose();
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
        child: otpForm(),
      ),
    );
  }

  otpForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "We will sent you an OTP on following Mobile Number to reset password : ",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildMobileNoField(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(6),
                child: EqButton(
                    text: "Send OTP",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTP_Password(
                                  number: _mobileNoController.text)),
                        );
                      }
                    }),
              ),
            ],
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
}