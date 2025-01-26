import 'package:flutter/material.dart';
import 'package:society_management_system/display_Flat_Screen.dart';
import 'package:society_management_system/global_Declaration/colors.dart';
import 'package:society_management_system/global_Declaration/strings.dart';

// ignore: camel_case_types
class wing_details_Screen extends StatefulWidget {
  final String wingName;
  final bool isLastWing;
  const wing_details_Screen(
      {super.key, required this.wingName, required this.isLastWing});

  @override
  State<wing_details_Screen> createState() => _wing_details_ScreenState();
}

// ignore: camel_case_types
class _wing_details_ScreenState extends State<wing_details_Screen> {
  final _wingNameController = TextEditingController();
  final _floorsController = TextEditingController();
  final _flatsPerFloorController = TextEditingController();

  @override
  void dispose() {
    _wingNameController.dispose();
    _floorsController.dispose();
    _flatsPerFloorController.dispose();
    super.dispose();
  }

  void _onNext() {
    int floors = int.parse(_floorsController.text);
    int flatsPerFloor = int.parse(_flatsPerFloorController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => display_Flat_Screen(
          wingName: _wingNameController.text,
          floors: floors,
          flatsPerFloor: flatsPerFloor,
          isLastWing: widget.isLastWing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: Text(
          "$wingDetailsAppbar - ${widget.wingName}",
          style: const TextStyle(color: appbarTextColor),
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
                      height: 50,
                    ),

                    // wing name input

                    TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter FullName of Student';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: _wingNameController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.home,
                          color: primaryColor,
                        ),
                        labelText: wingNameInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    //no of floors input

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
                      controller: _floorsController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.dialpad,
                          color: primaryColor,
                        ),
                        labelText: noOfFloorsInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    // no of flats per floor

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
                      controller: _flatsPerFloorController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.dialpad,
                          color: primaryColor,
                        ),
                        labelText: noOfFlatsPerFloorInput,
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
                        onPressed: _onNext,
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
