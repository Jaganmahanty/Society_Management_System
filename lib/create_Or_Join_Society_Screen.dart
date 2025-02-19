import 'package:flutter/material.dart';
import 'package:society_management_system/join_Building_Screen.dart';
import 'package:society_management_system/society_Details_Screen.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Create_or_Join_Society extends StatefulWidget {
  const Create_or_Join_Society({super.key});

  @override
  State<Create_or_Join_Society> createState() => _Create_or_Join_SocietyState();
}

class _Create_or_Join_SocietyState extends State<Create_or_Join_Society> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarColor,
        title: Text(
          createOrJoinAppbar,
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customContainer(
                  message: createSocietyMsg,
                  buttonText: createSocietyButton,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Society_Details()));
                  }),
              SizedBox(height: 30),
              customContainer(
                  message: joinSocietyMsg,
                  buttonText: joinSocietyButton,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => join_Building()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainer({
    required String message,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 15),
              child: SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
