import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/member_Section/complaint/add_Complaint.dart';
import 'package:society_management_system/member_Section/complaint/display_Complaints.dart';
import 'package:society_management_system/common/eqWidget/eqBottomNavigationBarButton.dart';

class Complaints_Member extends StatefulWidget {
  const Complaints_Member({super.key});

  @override
  State<Complaints_Member> createState() => _Complaints_MemberState();
}

class _Complaints_MemberState extends State<Complaints_Member>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;
  List<Map<String, dynamic>> _allComplaints = [];
  bool isLoading = true;
  String selectedTab = "soc";
  String addbtnText = "Add Complaint to Society";

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        selectedTab = _tabController.index == 0 ? "soc" : "wing";
        addbtnText = selectedTab == "soc"
            ? "Add Complaint to Society"
            : "Add Complaint to Wing";
        _fetchComplaints();
      });
    });

    _fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            "Complaints",
            style: TextStyle(color: appbarTextColor),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: "My Society"),
              Tab(text: "My Wing"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: EqBottomButton(
        onPress: () async {
          int selectedIndex = _tabController.index;
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add_Complaint(tabIndex: selectedIndex),
            ),
          );
          _fetchComplaints();
        },
        buttonText: addbtnText,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchComplaints,
              child: _allComplaints.isEmpty
                  ? const Center(child: Text("No complaints found"))
                  : ListView.builder(
                      itemCount: _allComplaints.length,
                      itemBuilder: (context, index) {
                        var comp = _allComplaints[index];

                        return InkWell(
                          onTap: () async {
                            bool? isUpdatedOrDeleted = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Display_Complaint(complaintId: comp["id"]),
                              ),
                            );

                            if (isUpdatedOrDeleted == true) {
                              _fetchComplaints();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comp["title"],
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    if (comp["detail"] != null &&
                                        comp["detail"].toString().isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          comp["detail"],
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(comp["madeBy"].toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(comp["dateTime"],
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  Future<void> _fetchComplaints() async {
    setState(() {
      isLoading = true;
    });

    try {
      var url =
          "https://bearpridejewelry.com/fetch_action.php?addTo=$selectedTab";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey("data")) {
          setState(() {
            _allComplaints =
                List<Map<String, dynamic>>.from(jsonResponse["data"]);
            isLoading = false;
          });
        } else {
          _showError("Invalid response format.");
        }
      } else {
        _showError("Failed to load complaints. Try again later.");
      }
    } catch (e) {
      _showError("An error occurred: $e");
    }
  }

  void _showError(String message) {
    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
