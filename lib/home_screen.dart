import 'package:flutter/material.dart';
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/create_Or_Join_Society_Screen.dart';

class Home_Sceeen extends StatefulWidget {
  final bool? userExists;
  const Home_Sceeen({super.key, this.userExists = false});

  @override
  State<Home_Sceeen> createState() => _Home_SceeenState();
}

class _Home_SceeenState extends State<Home_Sceeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: widget.userExists! ? false : true,
        title: Text(
          '${Globals.fName} ${Globals.lName}',
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      body: Container(
        color: Colors.blueGrey[50],
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Create_or_Join_Society()));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: primaryColor, width: 1.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Connect : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Align(
                            // alignment: Alignment.centerLeft,
                            child: Text(
                              "Click here to start the process of creating a new society or joining an existing one effortlessly !!",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
