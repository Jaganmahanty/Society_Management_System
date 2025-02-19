import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:society_management_system/common/global_section/colors.dart';
import 'package:society_management_system/authentication/login/login_Screen.dart';

void main() {
  //HELLOW WORLD !!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // adding comment here later will delete.
        primaryColor: primaryColor,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: appbarColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        // scrollbarTheme: ScrollbarThemeData(
        // thumbColor: WidgetStateProperty.all(Colors.green),
        // )
      ),
      debugShowCheckedModeBanner: false,
      home: Login_Page(),
    );
  }
}
