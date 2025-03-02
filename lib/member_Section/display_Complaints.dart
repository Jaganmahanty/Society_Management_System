import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:society_management_system/common/eqWidget/eqAlertDialog2.dart';
import 'package:society_management_system/common/function.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/member_Section/update_complaint.dart';

class Display_Complaint extends StatefulWidget {
  final String complaintId;
  const Display_Complaint({super.key, required this.complaintId});

  @override
  State<Display_Complaint> createState() => _Display_ComplaintState();
}

class _Display_ComplaintState extends State<Display_Complaint> {
  Map<String, dynamic>? complaint;
  bool isLoading = true;
  bool isBottomBarVisible = true;

  @override
  void initState() {
    super.initState();
    _fetchComplaintDetails();
  }

  Future<void> _fetchComplaintDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      var url =
          "https://bearpridejewelry.com/fetch_action.php?id=${widget.complaintId}";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey("data") &&
            jsonResponse["data"] is List &&
            jsonResponse["data"].isNotEmpty) {
          setState(() {
            complaint = {
              "id": jsonResponse["data"][0]["id"].toString(),
              "title": jsonResponse["data"][0]["title"],
              "detail": jsonResponse["data"][0]["detail"] ?? "",
              "img": jsonResponse["data"][0]["img"] is List
                  ? jsonResponse["data"][0]["img"]
                  : [],
              "dateTime": jsonResponse["data"][0]["dateTime"].toString(),
              "madeBy": jsonResponse["data"][0]["madeBy"].toString(),
            };
            isLoading = false;
          });
        } else {
          _showError("Invalid response format.");
        }
      } else {
        _showError("Failed to load complaint details. Try again later.");
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

  void _showFullScreenImage(String imgUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imgUrl),
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EqAlertDialog2(
          title: "Confirm Delete",
          message: "Are you sure you want to delete this complaint?",
          onConfirm: _deleteComplaint,
        );
      },
    );
  }

  Future<void> _deleteComplaint() async {
    try {
      var url = "https://bearpridejewelry.com/delete_action.php";

      var bodyData = jsonEncode({"id": widget.complaintId});

      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: bodyData,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"] == "success") {
          eqToast("Complaint deleted successfully!");
          Navigator.pop(context, true);
        } else {
          eqToast("Failed: ${jsonResponse["message"]}");
        }
      } else {
        eqToast("Error deleting complaint, Try later.");
      }
    } catch (e) {
      eqToast("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          complaint == null
              ? "Complaint Details"
              : "Complaint By : ${complaint!["madeBy"]}",
          style: const TextStyle(color: appbarTextColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true); // Return true when going back
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : complaint == null
              ? const Center(child: Text("Complaint not found"))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                complaint!["title"],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
                                height: 20,
                              ),
                              Text(
                                complaint!["detail"],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (complaint!["img"] != null &&
                            complaint!["img"] is List &&
                            (complaint!["img"] as List).isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: (complaint!["img"] as List).length,
                            itemBuilder: (context, index) {
                              String imgUrl =
                                  (complaint!["img"] as List)[index];
                              return GestureDetector(
                                onTap: () => _showFullScreenImage(imgUrl),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image,
                                                size: 50),
                                  ),
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: 12),
                        Text(
                          "Date & Time: ${complaint!["dateTime"]}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: isBottomBarVisible
          ? BottomAppBar(
              color: Colors.grey[50],
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 10, // Set height here
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Update_Complaint(complaintId: complaint!["id"]),
                          ),
                        ).then((value) {
                          if (value == true) {
                            _fetchComplaintDetails(); // Refresh complaint details after update
                          }
                        });
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Update",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white),
                    ),
                    ElevatedButton.icon(
                      onPressed: _confirmDelete,
                      icon: const Icon(Icons.delete),
                      label: const Text(
                        "Delete",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

// Full-Screen Image Viewer
class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 100, color: Colors.white),
        ),
      ),
    );
  }
}
