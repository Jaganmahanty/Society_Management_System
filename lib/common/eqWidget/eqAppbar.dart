
import 'package:flutter/material.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class EqAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String TitleText;
  final bool? backBtn;
  final bool? centerTitle;
  List<Widget> actions = [];

  EqAppBar(
      {super.key,
      required this.TitleText,
      this.backBtn = true,
      this.actions = const [],
      this.centerTitle = false})
      : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: centerTitle,
        backgroundColor: primaryColor,
        leading: backBtn!
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white)
            : null,
        title: Text(
          TitleText,
          style: TextStyle(fontFamily: 'Roboto', color: Colors.white),
        ),
        actions: actions);
  }
}
