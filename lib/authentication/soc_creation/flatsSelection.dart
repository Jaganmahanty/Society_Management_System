import 'package:flutter/material.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class FlatSelectionScreen extends StatefulWidget {
  final String wingChar;
  final int noofFloor;
  final int noOfFlats;
  const FlatSelectionScreen(
      {super.key,
      required this.noofFloor,
      required this.noOfFlats,
      required this.wingChar});

  @override
  FlatSelectionScreenState createState() => FlatSelectionScreenState();
}

class FlatSelectionScreenState extends State<FlatSelectionScreen> {
  Map<int, bool> flatStatus = {};

  List<List<int>> generateGridData(int floors, int flats) {
    List<List<int>> grid = [];
    int startingFloor = floors * 100;
    for (int i = floors; i > 0; i--) {
      List<int> row =
          List.generate(flats, (index) => startingFloor + index + 1);
      grid.add(row);
      startingFloor -= 100;
    }
    return grid;
  }

  late List<List<int>> gridData;

  @override
  void initState() {
    super.initState();
    gridData = generateGridData(widget.noofFloor, widget.noOfFlats);

    for (var row in gridData) {
      for (var flat in row) {
        flatStatus[flat] = true;
      }
    }
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
            "Flats status for wing - ${widget.wingChar}",
            style: TextStyle(color: appbarTextColor),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                "Customize the flats based on their status : ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.square, color: Colors.green),
                  SizedBox(width: 5),
                  Text("Active"),
                  SizedBox(width: 20),
                  Icon(Icons.square, color: Colors.red),
                  SizedBox(width: 5),
                  Text("Inactive"),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.noOfFlats,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.5),
                  itemCount: gridData.expand((i) => i).length,
                  itemBuilder: (context, index) {
                    int flatNumber = gridData.expand((i) => i).toList()[index];
                    bool isActive = flatStatus[flatNumber] ?? true;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          flatStatus[flatNumber] =
                              !(flatStatus[flatNumber] ?? true);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isActive ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "$flatNumber",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              EqButton(
                  text: "Save status",
                  onPressed: () {
                    // Map<String, bool> completeFlatStatus = {};
                    List<Map<String, dynamic>> flatDataList = [];

                    for (var row in gridData) {
                      for (var flat in row) {
                        // completeFlatStatus[flat.toString()] =
                        //     flatStatus[flat] ?? true;
                        flatDataList.add({
                          'flat': flat.toString(),
                          'active': flatStatus[flat] == true ? 'Y' : 'N',
                        });
                      }
                    }
                    print("Selected Flats JSON 1 : $flatDataList");
                    Navigator.pop(context, flatDataList);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    bool? confirmExit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save progress?'),
          content:
              Text('Are you sure you want to leave this page? Save status ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Discard'),
            ),
            TextButton(
              onPressed: () {
                List<Map<String, dynamic>> flatDataList = [];
                for (var row in gridData) {
                  for (var flat in row) {
                    flatDataList.add({
                      'flat': flat.toString(),
                      'status': flatStatus[flat] ?? true,
                    });
                  }
                }
                // String jsonResult = jsonEncode(flatDataList);
                print("Selected Flats JSON 0 : $flatDataList");
                Navigator.of(context).pop(false);
                Navigator.pop(context, flatDataList);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
    return confirmExit ?? false;
  }
}
