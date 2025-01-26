import 'package:flutter/material.dart';
import 'package:society_management_system/global_Declaration/colors.dart';
import 'package:society_management_system/global_Declaration/strings.dart';
import 'package:society_management_system/wing_Details_Screen.dart';

// ignore: camel_case_types
class set_Up_Wings_Screen extends StatefulWidget {
  final int noOfWings;
  const set_Up_Wings_Screen({super.key, required this.noOfWings});

  @override
  State<set_Up_Wings_Screen> createState() => _set_Up_Wings_ScreenState();
}

// ignore: camel_case_types
class _set_Up_Wings_ScreenState extends State<set_Up_Wings_Screen> {
  late int numberOfWings;

  @override
  void initState() {
    super.initState();
    numberOfWings = widget.noOfWings; // Convert String to intno
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: const Text(
          setupWingsAppbar,
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              setupWingsMsg,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 35,
                ),
                itemCount: numberOfWings,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      bool isLastWing = (index ==
                          numberOfWings - 1); // Check if this is the last wing
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => wing_details_Screen(
                                  wingName:
                                      'Wing ${String.fromCharCode(65 + index)}',
                                  isLastWing:
                                      isLastWing, // Pass the isLastWing value
                                )),
                      );
                    },
                    child: Text(
                      'Setup ${String.fromCharCode(65 + index)}',
                      style: const TextStyle(
                          fontSize: 16, color: beforeSetupWingsButtonText),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
