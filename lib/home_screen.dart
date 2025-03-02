import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/member_Section/profile.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/member_Section/dashboard_Member.dart';
import 'package:society_management_system/authentication/login/login_Screen.dart';
import 'package:society_management_system/w_admin_Section/dashboard_Wing_Admin.dart';
import 'package:society_management_system/s_admin_section/dashboard_Society_Admin.dart';
import 'package:society_management_system/authentication/soc_creation/create_Or_Join_Society_Screen.dart';

class Home_Sceeen extends StatefulWidget {
  final bool? userExists;
  const Home_Sceeen({super.key, this.userExists = false});

  @override
  State<Home_Sceeen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Sceeen> {
  var user_mobile = '';
  var role_s_admin = '';
  var role_w_admin = '';
  var role_member = '';

  var socName = '';
  var accessCode = '';
  bool userFound = false;

  @override
  void initState() {
    super.initState();
    getData();
    getUserRoles();
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
      drawer: buildCommonDrawer(),
      body: Container(
        color: Colors.blueGrey[50],
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userFound
                    ? Row(
                        children: [
                          if (role_member == "member")
                            userRole("Member", socName, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Dashboard_Member()));
                            }),
                          SizedBox(width: 10),
                          if (role_w_admin == "admin_w")
                            userRole("W Admin", socName, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Dashboard_Wing_Admin()));
                            }),
                          SizedBox(width: 10),
                          if (role_s_admin == "admin_s")
                            userRole("S Admin", socName, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          dashboard_Society_Admin()));
                            }),
                        ],
                      )
                    : Center(child: showLoading()),
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

  InkWell userRole(title, socName, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
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
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Icon(size: 50, Icons.apartment, color: primaryColor),
            SizedBox(height: 5),
            Text(
              socName,
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Drawer buildCommonDrawer() {
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
                    "${Globals.fName} ${Globals.lName}",
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
                  onTap: () async {
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                isMember: false, mobile: Globals.mobile)));
                    if (res != null) {
                      Scaffold.of(context).closeDrawer();
                    }
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
                  title: Text('Log out'),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login_Page()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getUserRoles() async {
    Globals.mobile = user_mobile = await getSettings("user_mobile");

    socName = await getSettings("socName");
    print('socName: $socName');
    accessCode = await getSettings("accessCode");
    print('accessCode: $accessCode');
    setState(() {});

    String api = "${Globals.domainUrl}/getuserrole.php?mobile=$user_mobile";
    print("API : $api");

    var response = await http.get(Uri.parse(api));
    var jsonData = jsonDecode(response.body);
    print('jsonData: $jsonData');
    if (jsonData != null && jsonData['success']) {
      var aMember = jsonData['member'];
      var aWAdmin = jsonData['admin_w'];
      var aSAdmin = jsonData['admin_s'];

      if (aMember.isNotEmpty) {
        role_member = "member";
        socName = aMember[0]['socname'];
        setSettings("accessCode", aMember[0]['accesscode'].toString());
      }
      if (aWAdmin.isNotEmpty) {
        role_w_admin = "admin_w";
        socName = aWAdmin[0]['socname'];
        setSettings("accessCode", aWAdmin[0]['accesscode'].toString());
      }
      if (aSAdmin.isNotEmpty) {
        role_s_admin = "admin_s";
        socName = aSAdmin[0]['socname'];
        setSettings("accessCode", aSAdmin[0]['accesscode'].toString());
      }

      print('role_member: $role_member');
      print('role_w_admin: $role_w_admin');
      print('role_s_admin: $role_s_admin');
      print('socName: $socName');
    }
    setState(() {
      userFound = true;
    });
  }

  Future<void> getData() async {
    // role_s_admin = await getSettings("userrole1");
    // role_w_admin = await getSettings("userrole2");
    // role_member = await getSettings("userrole3");
    // print('role_w_admin: $role_w_admin');
    // print('role_member: $role_member');
    // print('s_admin_role: $role_s_admin');
    //
  }
}
