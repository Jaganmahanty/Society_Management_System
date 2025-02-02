import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:society_management_system/dashboard_Society_Admin.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class Add_Vehicles extends StatefulWidget {
  const Add_Vehicles({super.key});

  @override
  State<Add_Vehicles> createState() => _Add_VehiclesState();
}

class _Add_VehiclesState extends State<Add_Vehicles> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _vehicleNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Vehicle",
          style: TextStyle(color: appbarTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    addVehicleForm(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 8, right: 8),
              child: EqButton(
                  text: "Add",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                dashboard_Society_Admin(accessCode: 1)),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  addVehicleForm() {
    return Center(
      child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vehicle No. : (Eg. GJ05XX1234) ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center),
                        SizedBox(height: 8),
                        ToggleSwitch(
                          minWidth: 150,
                          totalSwitches: 2,
                          cornerRadius: 20.0,
                          initialLabelIndex: 0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          labels: ['Two Wheeler', 'Four Wheeler'],
                          icons: [Icons.two_wheeler, Icons.car_rental],
                          activeBgColors: [
                            [primaryColor],
                            [Colors.orangeAccent]
                          ],
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                buildVehicleNoField(),
              ],
            ),
          )),
    );
  }

  EqTextField buildVehicleNoField() {
    return EqTextField(
      length: 10,
      controller: _vehicleNoController,
      keyboardType: TextInputType.phone,
      hintText: "Enter Vehicle No",
      labelText: "Vehicle No",
      prefixIcon: Icon(Icons.bike_scooter, color: primaryColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Vehicle No can't be empty ";
        }
        return null;
      },
    );
  }
}
