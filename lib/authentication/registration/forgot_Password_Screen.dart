import 'package:flutter/material.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class Forgot_Password extends StatefulWidget {
  final String number;
  const Forgot_Password({super.key, required this.number});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  late final TextEditingController _mobileNoController;

  @override
  void initState() {
    super.initState();
    _mobileNoController = TextEditingController(text: widget.number);
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
                    const SizedBox(height: 200),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "We will sent you an OTP on following Mobile Number - ",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                          color: Colors.deepPurpleAccent,
                        ),
                        labelText: "Enter Mobile No.",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const join_Or_Create_Building()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shadowColor: Colors.black,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          "Send OTP",
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
