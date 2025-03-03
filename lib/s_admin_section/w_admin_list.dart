import 'package:flutter/material.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/s_admin_section/add_w_admin.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class Wing_Admin_List extends StatefulWidget {
  const Wing_Admin_List({super.key});

  @override
  State<Wing_Admin_List> createState() => _Wing_Admin_ListState();
}

class _Wing_Admin_ListState extends State<Wing_Admin_List> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: const Text(
          "Admins",
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      // addAdminForm(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: EqButton(
                  text: "Add Wing Admin",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => add_Wing_Admin()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
