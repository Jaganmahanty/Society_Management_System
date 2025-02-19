import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:society_management_system/profile.dart';
import 'package:society_management_system/home_screen.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';
import 'package:society_management_system/common/eqWidget/quickAccessMenu.dart';
import 'package:society_management_system/wing_Admin_Section/dashboard_Wing_Admin.dart';

class dashboard_Society_Admin extends StatefulWidget {
  final int? accessCode;
  const dashboard_Society_Admin({super.key, this.accessCode});

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
      drawer: buildSocietyAdminDrawer(),
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
                SizedBox(height: 20),
                buildQuickAccess(),
                SizedBox(height: 20),
                buildDirectories(),
                SizedBox(height: 20),
                buildCommunication(),
                SizedBox(height: 20),
                buildSocialInfra(),
                SizedBox(height: 20),
                buildSocietyStaff(),
                SizedBox(height: 20),
                buildOthers(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  QuickAccessMenu buildQuickAccess() {
    return QuickAccessMenu(
      title: "Quick Access :",
      items: [
        {
          'icon': Icons.person_outline,
          'title': "Wing Admin",
          'onPressed': () {
            print("Update MaintenenceHome Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessMenu buildDirectories() {
    return QuickAccessMenu(
      title: "Directories :",
      items: [
        {
          'icon': Icons.person,
          'title': "Members\n ",
          'onPressed': () {
            print("Person Icon Pressed");
          },
        },
        {
          'icon': Icons.car_repair_outlined,
          'title': "Vehicle\n ",
          'onPressed': () {
            print("Vehicle Icon Pressed");
          },
        },
        {
          'icon': Icons.call,
          'title': "Contact\nDirectory",
          'onPressed': () {
            print("Call Icon Pressed");
          },
        },
        {
          'icon': Icons.bar_chart,
          'title': "Statictics\n ",
          'onPressed': () {
            print("Statictics Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessMenu buildCommunication() {
    return QuickAccessMenu(
      title: "Communication :",
      items: [
        {
          'icon': Icons.timer_sharp,
          'title': "Meetings",
          'onPressed': () {
            print("Meetings Icon Pressed");
          },
        },
        {
          'icon': Icons.announcement,
          'title': "Announcement",
          'onPressed': () {
            print("Announcement Icon Pressed");
          },
        },
        {
          'icon': Icons.comment,
          'title': "Complaints",
          'onPressed': () {
            print("Complaints Icon Pressed");
          },
        },
        {
          'icon': Icons.comment_bank_outlined,
          'title': "Suggestions",
          'onPressed': () {
            print("Suggestions Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessMenu buildSocialInfra() {
    return QuickAccessMenu(
      title: "Social Infrastructure :",
      items: [
        {
          'icon': Icons.business_outlined,
          'title': "Edit Wings",
          'onPressed': () {
            print("Add resources Icon Pressed");
          },
        },
        {
          'icon': Icons.info,
          'title': "Society\nInformation",
          'onPressed': () {
            print("Social info Icon Pressed");
          },
        },
        {
          'icon': Icons.check_circle_outline,
          'title': "Rules\n ",
          'onPressed': () {
            print("Rules Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessMenu buildSocietyStaff() {
    return QuickAccessMenu(
      title: "Society Support Staff :",
      items: [
        {
          'icon': Icons.person_search_sharp,
          'title': "Gate Keeper",
          'onPressed': () {
            print("Gate Icon Pressed");
          },
        },
        {
          'icon': Icons.person_add,
          'title': "Daily Helper",
          'onPressed': () {
            print("helper Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessMenu buildOthers() {
    return QuickAccessMenu(
      title: "Other :",
      items: [
        {
          'icon': Icons.person_add,
          'title': "Memory Gallery",
          'onPressed': () {
            print("Memory Icon Pressed");
          },
        },
        {
          'icon': Icons.person_4_outlined,
          'title': "Visitors",
          'onPressed': () {
            print("Visitore Icon Pressed");
          },
        },
      ],
    );
  }

  Drawer buildSocietyAdminDrawer() {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    strUsername,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: primaryColor),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_box, color: primaryColor),
                  title: Text('Feedback'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: primaryColor),
                  title: Text('Terms & Condition'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.notifications, color: primaryColor),
                  title: Text('Privacy Policy'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help, color: primaryColor),
                  title: Text('Contact Us'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help, color: primaryColor),
                  title: Text('About Us'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Exit to Home Screen'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home_Sceeen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
