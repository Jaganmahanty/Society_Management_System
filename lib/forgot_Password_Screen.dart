import 'package:flutter/material.dart';
import 'package:society_management_system/global_Declaration/colors.dart';

// ignore: camel_case_types
class forgot_Password extends StatefulWidget {
  final String number;
  const forgot_Password({super.key, required this.number});

  @override
  State<forgot_Password> createState() => _forgot_PasswordState();
}

// ignore: camel_case_types
class _forgot_PasswordState extends State<forgot_Password> {
  late final TextEditingController _mobileNoController;

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController with the passed number
    _mobileNoController = TextEditingController(text: widget.number);
  }

  @override
  void dispose() {
    // Dispose the controller to free resources
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
                    const SizedBox(
                      height: 200,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // This ensures the text aligns to the left
                        child: Text(
                          "We will sent you an OTP on following Mobile Number - ",
                          style: TextStyle(
                            fontSize: 17,
                          ),
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
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
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
                          backgroundColor: Colors.deepPurpleAccent,
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
