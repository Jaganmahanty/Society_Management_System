import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/authentication/soc_creation/wing_Details_Screen.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/s_admin_section/dashboard_Society_Admin.dart';

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
  late List<String> wingNames;

  @override
  void initState() {
    super.initState();
    numberOfWings = widget.noOfWings;
    wingStatus = List.generate(numberOfWings, (index) => false);

    wingResults = List.generate(widget.noOfWings, (index) => "");
    wingNames = List.generate(
        numberOfWings, (index) => String.fromCharCode(65 + index));
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
                  wingNames,
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
                    print("Result type :->  ${res.runtimeType}");
                    var resJson = json.decode(res);

                    if (res != null) {
                      setState(() {
                        wingResults[wingIndex] = res;
                        wingStatus[wingIndex] = true;
                        wingNames[wingIndex] = resJson['wingInfo']['wingName'];
                      });
                    }

                    if (isLastWing) {
                      bool allCompleted = wingResults
                          .every((result) => result != null && result != "");

                      if (allCompleted) {
                        Map<String, dynamic> combinedData = {};
                        List<Map<String, dynamic>> wingDataList = [];
                        // List<Map<String, dynamic>> flatDataList = [];

                        for (int i = 0; i < numberOfWings; i++) {
                          var result = wingResults[i];

                          if (result is String) {
                            try {
                              var decodedResult = json.decode(result);
                              if (decodedResult is Map) {
                                result = decodedResult;
                                print('result: $result');
                              }
                            } catch (e) {
                              //
                            }
                          }

                          if (result is Map) {
                            // Society Data (this remains the same for all wings)
                            if (i == 0) {
                              combinedData['society'] = {
                                'socName': widget.socName,
                                'socAddr': widget.socAddr,
                              };
                            }

                            // Wing Data
                            wingDataList.add({
                              'wingName': wingNames[i],
                              'noofFloor': result['wingInfo']['noofFloor'],
                              'flatsPerFloor': result['wingInfo']
                                  ['flatsPerFloor'],
                              'flats': result['statusInfo'],
                            });
                          }
                        }

                        combinedData['wings'] = wingDataList;
                        combinedData['mobile'] =
                            await getSettings("user_mobile");

                        var data = json.encode(combinedData);
                        print("Combined Data: \n$data");

                        createSoc(combinedData);
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
    List<String> wingNames,
    Function(int) OnTap,
  ) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 35),
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
            wingNames[index],
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        );
      },
    );
  }

  Future<bool> createSoc(data) async {
    showProgressIndicator(context);

    // String strMobile = _mobileNoController.text;
    // String strPin = _pinController.text;

    String url = "${Globals.domainUrl}/society_creation.php";

    var body = json.encode(data);
    print(url);
    print(body);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response.body);
    var jsonData = jsonDecode(response.body);

    hideIndicator(context);

    if (jsonData['success']) {
      setSettings("usertype", "soc_admin");
      setSettings("socName", jsonData['soc']['name'].toString());
      setSettings("accessCode", jsonData['soc']['accesscode'].toString());
      setSettings("userrole1", "admin_s");
      showSnakebar(context,
          color: Colors.green, title: jsonData['message'], milliseconds: 2500);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => dashboard_Society_Admin(
                  accessCode: jsonData['soc']['accesscode'])));
    } else if (jsonData['success'] == false) {
      showSnakebar(context,
          color: Colors.red, title: jsonData['message'], milliseconds: 2500);
    } else {
      showSnakebar(context,
          color: Colors.red, title: jsonData['message'], milliseconds: 2500);
    }
    return true;
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
