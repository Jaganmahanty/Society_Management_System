import 'package:flutter/material.dart';
import 'package:society_management_system/authentication/registration/reset_Password_Screen.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class OTP_Password extends StatefulWidget {
  final String number;
  const OTP_Password({super.key, required this.number});

  @override
  State<OTP_Password> createState() => _OTP_PasswordState();
}

class _OTP_PasswordState extends State<OTP_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _OTPController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _OTPController.dispose();
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
              Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "We have sent you an OTP on following Mobile Number : ${widget.number} ",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildOTPField(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(6),
                child: EqButton(
                    text: "Submit",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Reset_Password()),
                        );
                      }
                    }),
              ),
            ],
          )),
    );
  }

  EqTextField buildOTPField() {
    return EqTextField(
      length: 6,
      controller: _OTPController,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(Icons.phone, color: primaryColor),
      hintText: "OTP",
      labelText: "Enter OTP",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Mobile No can't be empty ";
        }
        return null;
      },
    );
  }
}
