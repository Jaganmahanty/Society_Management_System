import 'package:flutter/material.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class join_Building extends StatefulWidget {
  const join_Building({super.key});

  @override
  State<join_Building> createState() => _join_BuildingState();
}

class _join_BuildingState extends State<join_Building> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accessCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Join Your Building',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: joinBuildingForm(),
      ),
    );
  }

  joinBuildingForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildAccessCodeField(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                    'Get your building access code from your society administrator .',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                    textAlign: TextAlign.justify),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(6),
                child: EqButton(
                    text: "Join",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => Reset_Password()),
                        // );
                      }
                    }),
              ),
            ],
          )),
    );
  }

  EqTextField buildAccessCodeField() {
    return EqTextField(
      length: 8,
      controller: _accessCodeController,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(Icons.dialpad, color: primaryColor),
      hintText: "Access Code",
      labelText: "Enter Access Code",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Access Code can't be empty ";
        }
        return null;
      },
    );
  }
}
