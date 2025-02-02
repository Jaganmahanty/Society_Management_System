import 'package:flutter/material.dart';
import 'package:society_management_system/common/eqWidget/eqButton.dart';
import 'package:society_management_system/common/eqWidget/eqTextField.dart';
import 'package:society_management_system/set_Up_Wings_Screen.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/common/global_section/strings.dart';

class Society_Details extends StatefulWidget {
  const Society_Details({super.key});

  @override
  State<Society_Details> createState() => _Society_DetailsState();
}

class _Society_DetailsState extends State<Society_Details> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _societyNameController = TextEditingController();
  final TextEditingController _societyAddrController = TextEditingController();
  final TextEditingController _noOfWingsController = TextEditingController();

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
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 45),
                    Image.asset('assets/images/building_details.png',
                        height: 200, fit: BoxFit.cover),
                    SizedBox(height: 20),
                    societyForm(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: EqButton(
                text: "Next",
                onPressed: () {
                  int noOfWings = int.tryParse(_noOfWingsController.text) ?? 0;
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              set_Up_Wings_Screen(noOfWings: noOfWings)),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  societyForm() {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSocNameField(),
              buildSocieryAddField(),
              buildNoOfWingsField(),
            ],
          ),
        ));
  }

  EqTextField buildSocNameField() {
    return EqTextField(
      controller: _societyNameController,
      prefixIcon: Icon(Icons.home, color: primaryColor),
      hintText: strSocietyNameInput,
      labelText: "Society Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Society Name can't be empty ";
        }
        return null;
      },
    );
  }

  TextFormField buildSocieryAddField() {
    return TextFormField(
      controller: _societyAddrController,
      maxLines: 3,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.place, color: primaryColor),
        hintText: strSocietyAddInput,
        labelText: "Society Address",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Society Address can't be empty";
        }
        return null;
      },
    );
  }

  EqTextField buildNoOfWingsField() {
    return EqTextField(
      length: 2,
      controller: _noOfWingsController,
      keyboardType: TextInputType.number,
      prefixIcon: Icon(Icons.dialpad, color: primaryColor),
      hintText: strNoOfWingsInput,
      labelText: "No of Wings",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "No of Wings can't be empty ";
        }
        return null;
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Form(
  //         child: SizedBox(
  //       width: double.infinity,
  //       child: Column(
  //         children: [
  //           Expanded(
  //               child: SingleChildScrollView(
  //             child: Padding(
  //               padding: EdgeInsets.all(24),
  //               child: Column(
  //                 children: [
  //                   SizedBox(height: 40),

  //                   SizedBox(
  //                     height: 70,
  //                   ),

  //                   // society name input

  //                   TextFormField(
  //                     // autovalidateMode: AutovalidateMode.onUserInteraction,
  //                     // validator: (value) {
  //                     //   if (value == null || value.isEmpty) {
  //                     //     return 'Enter FullName of Student';
  //                     //   } else {
  //                     //     return null;
  //                     //   }
  //                     // },
  //                     controller: _societyNameController,
  //                     expands: false,
  //                     decoration: InputDecoration(
  //                       prefixIcon: Icon(
  //                         Icons.home,
  //                         color: primaryColor,
  //                       ),
  //                       labelText: strSocietyNameInput,
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(7))),
  //                     ),
  //                   ),

  //                   SizedBox(
  //                     height: 40,
  //                   ),

  //                   //society address input

  //                   TextFormField(
  //                     // autovalidateMode: AutovalidateMode.onUserInteraction,
  //                     // validator: (value) {
  //                     //   if (value == null || value.isEmpty) {
  //                     //     return 'Enter FullName of Student';
  //                     //   } else {
  //                     //     return null;
  //                     //   }
  //                     // },
  //                     controller: _societyNameController,
  //                     expands: false,
  //                     maxLines: 3,
  //                     decoration: InputDecoration(
  //                       prefixIcon: Icon(
  //                         Icons.place,
  //                         color: primaryColor,
  //                       ),
  //                       labelText: strSocietyAddInput,
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(7))),
  //                     ),
  //                   ),

  //                   SizedBox(
  //                     height: 40,
  //                   ),

  //                   //No. of wings input

  //                   TextFormField(
  //                     keyboardType: TextInputType.phone,
  //                     // autovalidateMode: AutovalidateMode.onUserInteraction,
  //                     // validator: (value) {
  //                     //   if (value == null || value.isEmpty) {
  //                     //     return 'Enter G.R.no.';
  //                     //   } else {
  //                     //     return null;
  //                     //   }
  //                     // },
  //                     controller: _noOfWingsController,
  //                     expands: false,
  //                     decoration: InputDecoration(
  //                       prefixIcon: Icon(
  //                         Icons.dialpad,
  //                         color: primaryColor,
  //                       ),
  //                       labelText: strNoOfWingsInput,
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(7))),
  //                     ),
  //                   ),

  //                   SizedBox(
  //                     height: 50,
  //                   ),

  //                   // Next Button

  //                   SizedBox(
  //                     width: double.infinity,
  //                     height: 45,
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         int noOfWings =
  //                             int.tryParse(_noOfWingsController.text) ?? 0;
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) =>
  //                                   set_Up_Wings_Screen(noOfWings: noOfWings)),
  //                         );
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: primaryColor,
  //                         foregroundColor: Colors.white,
  //                         // Text color
  //                         shadowColor: Colors.black, // Shadow color
  //                         elevation: 5, // Elevation of the button
  //                         shape: RoundedRectangleBorder(
  //                           // Shape of the button
  //                           borderRadius:
  //                               BorderRadius.circular(7), // Rounded corners
  //                         ),
  //                         // Padding inside button
  //                       ),
  //                       child: Text(
  //                         "Next",
  //                         style: TextStyle(fontSize: 17),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ))
  //         ],
  //       ),
  //     )),
  //   );
  // }
}
