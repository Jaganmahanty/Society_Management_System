import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/wing_Admin_Section/dashboard_Wing_Admin.dart';

class dashboard_Society_Admin extends StatefulWidget {
  final int accessCode;
  const dashboard_Society_Admin({super.key, required this.accessCode});

  @override
  State<dashboard_Society_Admin> createState() =>
      _dashboard_Society_AdminState();
}

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
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dashboard_Wing_Admin()));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Building Access Code : ",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
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
                            IconButton(
                              onPressed: () {
                                Share.share(
                                    'Join our society using this access code: ${widget.accessCode}',
                                    subject: 'Society Access Code');
                              },
                              icon: Icon(Icons.share,
                                  size: 18, color: primaryColor),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Click here invite society members to the society by sharing the Access Code.",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
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
