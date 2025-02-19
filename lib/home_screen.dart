import 'package:flutter/material.dart';
import 'package:society_management_system/profile.dart';
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/create_Or_Join_Society_Screen.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Home_Sceeen extends StatefulWidget {
  final bool? userExists;
  const Home_Sceeen({super.key, this.userExists = false});

  @override
  State<Home_Sceeen> createState() => _Home_SceeenState();
}

class _Home_SceeenState extends State<Home_Sceeen> {
  var socName = '';
  var accessCode = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: widget.userExists! ? false : true,
        title: Text(
          '${Globals.fName} ${Globals.lName}',
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      drawer: buildWingAdminDrawer(),
      body: Container(
        color: Colors.blueGrey[50],
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (accessCode.isNotEmpty && socName.isNotEmpty)
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 2,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              'G-103 / Owner',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Icon(size: 50, Icons.apartment, color: primaryColor),
                          SizedBox(height: 5),
                          Text(
                            socName,
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 20),
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

  Drawer buildWingAdminDrawer() {
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

  Future<void> getData() async {
    socName = await getSettings("socName");
    print('socName: ${socName}');
    accessCode = await getSettings("accessCode");
    print('accessCode: ${accessCode}');
    setState(() {});
    //
  }
}
