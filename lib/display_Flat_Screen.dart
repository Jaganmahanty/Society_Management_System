import 'package:flutter/material.dart';
import 'package:society_management_system/dashboard_Society_Admin.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class display_Flat_Screen extends StatefulWidget {
  final String wingName;
  final int floors;
  final int flatsPerFloor;
  final bool isLastWing;

  const display_Flat_Screen({
    super.key,
    required this.wingName,
    required this.floors,
    required this.flatsPerFloor,
    required this.isLastWing,
  });

  @override
  State<display_Flat_Screen> createState() => _display_Flat_ScreenState();
}

class _display_Flat_ScreenState extends State<display_Flat_Screen> {
  late List<bool> _isFlatDead;
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _isFlatDead =
        List<bool>.filled(widget.floors * widget.flatsPerFloor, false);
  }

  void _toggleFlatState(int index) {
    setState(() {
      _isFlatDead[index] = !_isFlatDead[index];
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  int accessCode = 24653716;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: Text(
          '$displayFlatsAppbar - ${widget.wingName}',
          style: const TextStyle(color: appbarTextColor),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                displayFlatsMsg,
                style: TextStyle(fontSize: 17),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment
                      .center, // This ensures the text aligns to the left
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        activeFlatsMsg,
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: activeFlatsColor,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        inactiveFlatsMsg,
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: inactiveFlatsColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Scrollbar(
                controller: _horizontalScrollController,
                thumbVisibility: true,
                thickness: 4.0, // Customize the thickness of the thumb
                radius: const Radius.circular(3),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _horizontalScrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0), // Space below the last row
                    child: Column(
                      children: List.generate(widget.floors, (floorIndex) {
                        // Reverse the floor order
                        int reversedFloorIndex = widget.floors - 1 - floorIndex;
                        return Row(
                          children:
                              List.generate(widget.flatsPerFloor, (flatIndex) {
                            // Calculate flat number
                            String flatNumber =
                                '${(reversedFloorIndex + 1) * 100 + flatIndex + 1}';
                            return GestureDetector(
                              onTap: () => _toggleFlatState(
                                  reversedFloorIndex * widget.flatsPerFloor +
                                      flatIndex),
                              child: Container(
                                margin: const EdgeInsets.all(4.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: _isFlatDead[reversedFloorIndex *
                                              widget.flatsPerFloor +
                                          flatIndex]
                                      ? inactiveFlatsColor
                                      : activeFlatsColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  flatNumber,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  ),
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
                    if (widget.isLastWing) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => dashboard_Society_Admin(
                                accessCode: accessCode)),
                      );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(toastMsg)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    // Text color
                    shadowColor: Colors.black, // Shadow color
                    elevation: 5, // Elevation of the button
                    shape: RoundedRectangleBorder(
                      // Shape of the button
                      borderRadius: BorderRadius.circular(7), // Rounded corners
                    ),
                    // Padding inside button
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
