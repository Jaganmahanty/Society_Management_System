import 'package:flutter/material.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/authentication/soc_creation/create_Or_Join_Society_Screen.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home Page',
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      body: Expanded(
          child: Scrollbar(
              child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //connect society container

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Create_or_Join_Society()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0, bottom: 4.0),
                            child: Text(
                              "Connect",
                              style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: Text(
                          homepageConnectMsg,
                          textAlign: TextAlign.justify,
                        ),  
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ))),
    );
  }
}
