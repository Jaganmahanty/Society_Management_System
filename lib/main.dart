import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:society_management_system/dashboard_Member.dart';
import 'package:society_management_system/global_Declaration/colors.dart';

void main() {
  //TT
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: appbarColor,
          iconTheme: IconThemeData(
            color: Colors.white, // Set the drawer icon color to white
          ),
        ),
        // scrollbarTheme: ScrollbarThemeData(
        // thumbColor: WidgetStateProperty.all(Colors.green),
        // )
      ),
      debugShowCheckedModeBanner: false,
      // home: const Login_Page(),
      home: const Dashboard_Member(),
    );
  }
}
