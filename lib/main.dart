import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:society_management_system/global_Declaration/colors.dart';
import 'package:society_management_system/login_Screen.dart';

void main() {
  runApp(const MaterialApp(home: main_Page()));
}

// ignore: camel_case_types
class main_Page extends StatefulWidget {
  const main_Page({super.key});

  @override
  State<main_Page> createState() => _main_PageState();
}

// ignore: camel_case_types
class _main_PageState extends State<main_Page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: appbarColor,
          ),
          textTheme: GoogleFonts.robotoTextTheme(),
          primaryColor: primaryColor,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.green),
          )),
      home: const login_Page(),
    );
  }
}
