import 'package:flutter/material.dart';
import 'package:society_management_system/global_Declaration/colors.dart';

class EqButton extends StatefulWidget {
  EqButton({
    super.key,
    Color? color,
    required this.text,
    required this.onPressed,
  }) : color = color ?? primaryColor;

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  State<EqButton> createState() => EqButtonState();
}

class EqButtonState extends State<EqButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          foregroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

// To auto trigger the onPressed ..
  void trigger() {
    widget.onPressed();
  }
}
