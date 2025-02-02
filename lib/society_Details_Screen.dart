import 'package:flutter/material.dart';
import 'package:society_management_system/set_Up_Wings_Screen.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class society_Details extends StatefulWidget {
  const society_Details({super.key});

  @override
  State<society_Details> createState() => _society_DetailsState();
}

class _society_DetailsState extends State<society_Details> {
  final TextEditingController _societyNameController = TextEditingController();
  final TextEditingController _noOfWingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: const Text(
          createOrJoinAppbar,
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
                      height: 40,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Image Asset

                          SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.asset(
                                'assets/images/building_details.png',
                                // width: 150, // Adjust size as needed
                                // height: 150, // Adjust size as needed
                                fit: BoxFit.cover, // Adjust fit as needed
                              )),
                        ]),
                    const SizedBox(
                      height: 70,
                    ),

                    // society name input

                    TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter FullName of Student';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: _societyNameController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.home,
                          color: primaryColor,
                        ),
                        labelText: societyNameInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    //society address input

                    TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter FullName of Student';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: _societyNameController,
                      expands: false,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.place,
                          color: primaryColor,
                        ),
                        labelText: societyAddressInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    //No. of wings input

                    TextFormField(
                      keyboardType: TextInputType.phone,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter G.R.no.';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: _noOfWingController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.dialpad,
                          color: primaryColor,
                        ),
                        labelText: noOfWingsInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    // Next Button

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          int noOfWings =
                              int.tryParse(_noOfWingController.text) ?? 0;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    set_Up_Wings_Screen(noOfWings: noOfWings)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          // Text color
                          shadowColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          "Next",
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
