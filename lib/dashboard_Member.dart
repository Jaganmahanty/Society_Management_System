import 'package:flutter/material.dart';
import 'package:society_management_system/quickAccessMenu.dart';
import 'package:society_management_system/global_Declaration/colors.dart';
import 'package:society_management_system/global_Declaration/strings.dart';

class Dashboard_Member extends StatefulWidget {
  const Dashboard_Member({super.key});

  @override
  State<Dashboard_Member> createState() => _Dashboard_MemberState();
}

class _Dashboard_MemberState extends State<Dashboard_Member> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          strAppbar,
          style: TextStyle(color: appbarTextColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_active, color: Colors.white)),
        ],
      ),
      drawer: buildMemberDrawer(),
      body: Container(
        color: Colors.blueGrey[50],
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
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

                // Container(
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(
                //       color: Colors.black,
                //       width: 0.2,
                //     ),
                //     borderRadius: BorderRadius.circular(8.0),
                //   ),
                //   child: Column(
                //     children: [
                //       const SizedBox(height: 7),
                //       Row(
                //         children: [
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const Padding(
                //                 padding: EdgeInsets.only(left: 10),
                //                 child: Align(
                //                   alignment: Alignment.centerLeft,
                //                   child: Text(
                //                     "Quick Access : ",
                //                     style: TextStyle(
                //                         fontWeight: FontWeight.bold,fontSize: 18),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 7),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           Column(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 decoration: BoxDecoration(
                //                   color: const Color.fromARGB(
                //                       255, 231, 230, 230),
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //                 child: IconButton(
                //                   icon:
                //                       Icon(Icons.home, color: primaryColor),
                //                   onPressed: () {},
                //                 ),
                //               ),
                //               const SizedBox(height: 5),
                //               const Text("Maintenence\nHistory",
                //                   textAlign: TextAlign.center),
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 decoration: BoxDecoration(
                //                   color: const Color.fromARGB(
                //                       255, 231, 230, 230),
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //                 child: IconButton(
                //                   icon: Icon(Icons.search,
                //                       color: primaryColor),
                //                   onPressed: () {},
                //                 ),
                //               ),
                //               const SizedBox(height: 5),
                //               const Text("Wing\nMaintenence\nReport",
                //                   textAlign: TextAlign.center),
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 decoration: BoxDecoration(
                //                   color: const Color.fromARGB(
                //                       255, 231, 230, 230),
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //                 child: IconButton(
                //                   icon: Icon(
                //                     Icons.notifications,
                //                     color: primaryColor,
                //                   ),
                //                   onPressed: () {},
                //                 ),
                //               ),
                //               const SizedBox(height: 5),
                //               const Text("Balance\nSheet",
                //                   textAlign: TextAlign.center),
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Container(
                //                 width: 50,
                //                 height: 50,
                //                 decoration: BoxDecoration(
                //                   color: const Color.fromARGB(
                //                       255, 231, 230, 230),
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //                 child: IconButton(
                //                   icon: Icon(
                //                     Icons.settings,
                //                     color: primaryColor,
                //                   ),
                //                   onPressed: () {},
                //                 ),
                //               ),
                //               const SizedBox(height: 5),
                //               const Text("Due\npayments",
                //                   textAlign: TextAlign.center),
                //             ],
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 7),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  QuickAccessWidget buildCommunication() {
    return QuickAccessWidget(
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
          'title': "Comment",
          'onPressed': () {
            print("Comment Icon Pressed");
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

  QuickAccessWidget buildDirectories() {
    return QuickAccessWidget(
      title: "Directories :",
      items: [
        {
          'icon': Icons.person,
          'title': "Members",
          'onPressed': () {
            print("Person Icon Pressed");
          },
        },
        {
          'icon': Icons.car_repair_outlined,
          'title': "Vehicle",
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
          'title': "Statictics",
          'onPressed': () {
            print("Statictics Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessWidget buildQuickAccess() {
    return QuickAccessWidget(
      title: "Quick Access :",
      items: [
        {
          'icon': Icons.home,
          'title': "Maintenence\nHistory",
          'onPressed': () {
            print("Home Icon Pressed");
          },
        },
        {
          'icon': Icons.search,
          'title': "Wing\nMaintenence\nReport",
          'onPressed': () {
            print("Search Icon Pressed");
          },
        },
        {
          'icon': Icons.notifications,
          'title': "Balance\nSheet",
          'onPressed': () {
            print("Notifications Icon Pressed");
          },
        },
        {
          'icon': Icons.settings,
          'title': "Due\nPayments",
          'onPressed': () {
            print("Settings Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessWidget buildSocietyStaff() {
    return QuickAccessWidget(
      title: "Society Support Staff :",
      items: [
        {
          'icon': Icons.person_search_sharp,
          'title': "Gate\nKeeper",
          'onPressed': () {
            print("Gate Icon Pressed");
          },
        },
        {
          'icon': Icons.person_add,
          'title': "DailyHelper",
          'onPressed': () {
            print("helper Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessWidget buildOthers() {
    return QuickAccessWidget(
      title: "Other :",
      items: [
        {
          'icon': Icons.person_add,
          'title': "Memory\nGallery",
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
        {
          'icon': Icons.construction,
          'title': "on Going\nTask",
          'onPressed': () {
            print("Task Icon Pressed");
          },
        },
      ],
    );
  }

  QuickAccessWidget buildSocialInfra() {
    return QuickAccessWidget(
      title: "Social Infrastructure :",
      items: [
        {
          'icon': Icons.business_outlined,
          'title': "Book\nResources",
          'onPressed': () {
            print("Book resources Icon Pressed");
          },
        },
        {
          'icon': Icons.info,
          'title': "Social\ninformation",
          'onPressed': () {
            print("Social info Icon Pressed");
          },
        },
        {
          'icon': Icons.check_circle_outline,
          'title': "Rules",
          'onPressed': () {
            print("Rules Icon Pressed");
          },
        },
        {
          'icon': Icons.backup_table_outlined,
          'title': "Bank",
          'onPressed': () {
            print("ank Icon Pressed");
          },
        },
      ],
    );
  }

  Drawer buildMemberDrawer() {
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
          ListView(
            children: [
              ListTile(
                leading: Icon(Icons.home, color: primaryColor),
                title: Text('Prfile'),
                onTap: () {},
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
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
