import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/wing_Details_Screen.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Set_Up_Wings_Screen extends StatefulWidget {
  final String socName;
  final String socAddr;
  final int noOfWings;
  const Set_Up_Wings_Screen(
      {super.key,
      required this.socName,
      required this.socAddr,
      required this.noOfWings});

  @override
  State<Set_Up_Wings_Screen> createState() => _Set_Up_Wings_ScreenState();
}

class _Set_Up_Wings_ScreenState extends State<Set_Up_Wings_Screen> {
  late int numberOfWings;
  late List<bool> wingStatus;
  var wingResults;

  @override
  void initState() {
    super.initState();
    numberOfWings = widget.noOfWings;
    wingStatus = List.generate(numberOfWings, (index) => false);

    wingResults = List.generate(widget.noOfWings, (index) => "");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appbarColor,
          title: Text(
            setupWingsAppbar,
            style: TextStyle(color: appbarTextColor),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(setupWingsMsg, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Expanded(
                child: buildWingGrid(
                  numberOfWings,
                  wingStatus,
                  wingResults,
                  (wingIndex) async {
                    bool isLastWing = (wingIndex == numberOfWings - 1);

                    var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => wing_details_Screen(
                            isLastWing: isLastWing, wingIndex: wingIndex),
                      ),
                    );

                    print("Result Data :->  $wingIndex");
                    print("Result Data :->  $res");

                    if (res != null) {
                      setState(() {
                        wingResults[wingIndex] = res;
                        if (wingResults[wingIndex] != null) {
                          wingStatus[wingIndex] = true;
                        }
                      });
                    }

                    if (isLastWing) {
                      bool allCompleted = wingResults
                          .every((result) => result != null && result != "");

                      if (allCompleted) {
                        List<Map<String, dynamic>> wingDataList = [];
                        for (int i = 0; i < numberOfWings; i++) {
                          var result = wingResults[i];

                          if (result is String) {
                            try {
                              var decodedResult = json.decode(result);
                              if (decodedResult is Map) {
                                result = decodedResult;
                                print('result: ${result}');
                              }
                            } catch (e) {
                              //
                            }
                          }

                          if (result is Map) {
                            wingDataList.add({
                              'socName': widget.socName,
                              'socAddr': widget.socAddr,
                              'srl': result['wingInfo']['srl'],
                              'wingName': String.fromCharCode(65 + i),
                              'noofFloor': result['wingInfo']['noofFloor'],
                              'flatsPerFloor': result['wingInfo']['flatsPerFloor'],
                              'flatStatus':result['statusInfo']
                            });
                          }
                        }

                        Map<String, dynamic> combinedData = {
                          'wingdata': wingDataList
                        };

                        var data = json.encode(combinedData);
                        print("Combined Data: \n$data");
                        
                        showProgressIndicator(context);

                        // callFunction to store winf data into datbase adn navigate to next screen
                        // storeData(Data);
                        await Future.delayed(Duration(milliseconds: 800));

                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Warning'),
                              content: Text(
                                  'Please complete all wings before proceeding.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildWingGrid(
    int wingNo,
    List<bool> wingStatus,
    List<String?> wingResults,
    Function(int) OnTap,
  ) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 35,
      ),
      itemCount: numberOfWings,
      itemBuilder: (context, index) {
        bool isSuccess = wingStatus[index];
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSuccess ? Colors.green : Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () => OnTap(index),
          child: Text(
            'Wing - ${String.fromCharCode(65 + index)}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        );
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
