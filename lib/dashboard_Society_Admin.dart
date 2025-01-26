import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:society_management_system/global_Declaration/colors.dart';

// ignore: camel_case_types
class dashboard_Society_Admin extends StatefulWidget {
  final int accessCode;
  const dashboard_Society_Admin({super.key, required this.accessCode});

  @override
  State<dashboard_Society_Admin> createState() =>
      _dashboard_Society_AdminState();
}

// ignore: camel_case_types
class _dashboard_Society_AdminState extends State<dashboard_Society_Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'DashBoard',
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      body: Container(
        color: Colors.blueGrey[50],
        height: double.infinity,
        child: Scrollbar(
            thumbVisibility: false,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Share.share(
                            'Join our society using this access code: ${widget.accessCode}',
                            subject: 'Society Access Code');
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft, // This ensures the text aligns to the left
                                        child: Text(
                                          "Building Access Code : ",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "${widget.accessCode}",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.share,
                                    size: 30,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Align(
                                alignment: Alignment
                                    .centerLeft, // This ensures the text aligns to the left
                                child: Text(
                                  "Click here invite society members to the society by sharing the Access Code.",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
