import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/globals.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/s_admin_section/add_admin/add_w_admin.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class Wing_Admin_List extends StatefulWidget {
  const Wing_Admin_List({super.key});

  @override
  State<Wing_Admin_List> createState() => _Wing_Admin_ListState();
}

class _Wing_Admin_ListState extends State<Wing_Admin_List> {
  List _wingAdminsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: const Text(
          "Wing Admins",
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _wingAdminsList.isEmpty
                      ? Center(
                          child: Text(
                            "No Wing Admins Found",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(12.0),
                          itemCount: _wingAdminsList.length,
                          itemBuilder: (context, index) {
                            final admin = _wingAdminsList[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: primaryColor,
                                      child: Text(
                                        admin["fname"][0].toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${admin["fname"]} ${admin["lname"]}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          admin["mobile"],
                                          style: const TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: EqButton(
                  text: "Add Wing Admin",
                  onPressed: () async {
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => add_Wing_Admin()));
                    if (res) {
                      fetchData();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    String api =
        "${Globals.domainUrl}/get_w_admin.php?accesscode=${Globals.accesscode}";
    print("API : $api");

    try {
      var response = await http.get(Uri.parse(api));
      var jsonData = jsonDecode(response.body);
      print('jsonData: $jsonData');

      if (jsonData != null && jsonData['success']) {
        setState(() {
          _isLoading = false;
          _wingAdminsList = jsonData['result'];
        });
      } else {
        setState(() {
          _wingAdminsList = [];
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        _wingAdminsList = [];
        _isLoading = false;
      });
    }
  }
}
