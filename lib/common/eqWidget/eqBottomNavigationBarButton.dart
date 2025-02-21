import 'package:flutter/material.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class EqBottomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPress;

  const EqBottomButton({
    super.key,
    required this.onPress,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPress, // ✅ Corrected callback reference
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
