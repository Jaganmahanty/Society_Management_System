import 'package:flutter/material.dart';
import 'package:society_management_system/society_Details_Screen.dart';
import 'package:society_management_system/global_Declaration/colors.dart';
import 'package:society_management_system/global_Declaration/strings.dart';
import 'package:society_management_system/join_Building_Screen.dart';

// ignore: camel_case_types
class create_Or_Join_Society extends StatefulWidget {
  const create_Or_Join_Society({super.key});

  @override
  State<create_Or_Join_Society> createState() => _create_Or_Join_SocietyState();
}

// ignore: camel_case_types
class _create_Or_Join_SocietyState extends State<create_Or_Join_Society> {
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
      body: Expanded(
          child: Scrollbar(
              child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              // create your society

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          createSocietyMsg,
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const society_Details()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.black,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: const Text(
                              createSocietyButton,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),

              // join your society

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          joinSocietyMsg,
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const join_Building()),
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
                              joinSocietyButton,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
