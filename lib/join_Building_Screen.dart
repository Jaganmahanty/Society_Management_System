import 'package:flutter/material.dart';

class join_Building extends StatefulWidget {
  const join_Building({super.key});

  @override
  State<join_Building> createState() => _join_BuildingState();
}

class _join_BuildingState extends State<join_Building> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent.shade100,
        title: const Text(
          'Join Your Building',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Scrollbar(
                    child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 250,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter G.R.no.';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      // controller: grnoController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.dialpad,
                          color: Colors.deepPurpleAccent,
                        ),
                        labelText: "Enter Access code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          'Get your building access code from your society administrator.',
                          style: TextStyle(fontSize: 15, color: Colors.black38),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                          // Text color
                          shadowColor: Colors.black, // Shadow color
                          elevation: 5, // Elevation of the button
                          shape: RoundedRectangleBorder(
                            // Shape of the button
                            borderRadius:
                                BorderRadius.circular(7), // Rounded corners
                          ),
                          // Padding inside button
                        ),
                        child: const Text(
                          "Join",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )))
          ],
        ),
      )),
    );
  }
}
