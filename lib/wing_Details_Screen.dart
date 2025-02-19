import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:society_management_system/flatsSelection.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class wing_details_Screen extends StatefulWidget {
  final int wingIndex;
  final bool isLastWing;
  const wing_details_Screen(
      {super.key, required this.wingIndex, required this.isLastWing});

  @override
  State<wing_details_Screen> createState() => _wing_details_ScreenState();
}

class _wing_details_ScreenState extends State<wing_details_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _wingNameController = TextEditingController();
  final TextEditingController _floorsController = TextEditingController();
  final TextEditingController _flatsPerFloorController =
      TextEditingController();

  var flatRes;
  var wingRes;

  @override
  void initState() {
    super.initState();
    _wingNameController.text = String.fromCharCode(65 + widget.wingIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text(
            'Set Up Wing - ${String.fromCharCode(65 + widget.wingIndex)} ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      wingForm(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: Row(
                children: [
                  Expanded(
                    child: EqButton(
                        text: "Save",
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            var wingName = _wingNameController.text.trim();
                            var noOfFloor = _floorsController.text.trim();
                            var flatsPerFloor =
                                _flatsPerFloorController.text.trim();
                            var body = [
                              {
                                "wingInfo": {
                                  "srl": widget.wingIndex + 1,
                                  "wingName": wingName,
                                  "noofFloor": noOfFloor,
                                  "flatsPerFloor": flatsPerFloor,
                                },
                                "statusInfo": flatRes
                              }
                            ];
                            var wingRes = json.encode(body[0]);
                            if (flatRes == null) {
                              showSnakebar(context,
                                  title: "Flat Details is required !!",
                                  color: Colors.red,
                                  milliseconds: 2000);
                            } else {
                              Navigator.pop(context, wingRes);
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Reset_Password()),
                            // );
                          }
                        }),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: EqButton(
                        color: secondaryColor,
                        text: "Flat Details",
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            var noOfFloor =
                                int.parse(_floorsController.text.trim());
                            var flatsPerFloor =
                                int.parse(_flatsPerFloorController.text.trim());

                            flatRes = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FlatSelectionScreen(
                                        wingChar: String.fromCharCode(
                                            65 + widget.wingIndex),
                                        noOfFlats: flatsPerFloor,
                                        noofFloor: noOfFloor)));
                            if (flatRes != null) {
                              print('flatRes => $flatRes');
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  wingForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildWingNameField(),
              buildNoOfFloorsField(),
              buildFlatsperFloorField(),
              SizedBox(height: 15),
            ],
          )),
    );
  }

  EqTextField buildWingNameField() {
    return EqTextField(
      // enabled: false,
      controller: _wingNameController,
      prefixIcon: Icon(Icons.home, color: primaryColor),
      hintText: "Wing Name",
      labelText: "Enter Wing Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Wing Name can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildNoOfFloorsField() {
    return EqTextField(
      length: 2,
      controller: _floorsController,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(Icons.dialpad, color: primaryColor),
      hintText: "No. of Floors",
      labelText: "Enter No. of Floors",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "No. of Floors can't be empty ";
        }
        return null;
      },
    );
  }

  EqTextField buildFlatsperFloorField() {
    return EqTextField(
      length: 2,
      controller: _flatsPerFloorController,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(Icons.dialpad, color: primaryColor),
      hintText: "No. of Flats per Floor",
      labelText: "Enter No. of Flats per Floor",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "No. of Flats per Floor can't be empty ";
        }
        return null;
      },
    );
  }

  Future<bool> _onWillPop() async {
    bool? confirmExit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure ?'),
          content: Text(
              'Are you sure you want to leave this page? Any unsaved data might be lost.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Leave'),
            ),
          ],
        );
      },
    );
    return confirmExit ?? false;
  }
}
