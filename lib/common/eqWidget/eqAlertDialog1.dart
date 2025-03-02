import 'package:flutter/material.dart';

//Alert Dialog with only ok button

class EqAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onOkPressed;

  // ignore: use_super_parameters
  const EqAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText = "OK",
    this.onOkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text(message, style: TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (onOkPressed != null) {
              onOkPressed!();
            }
          },
          child: Text(buttonText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

void showEqAlertDialog(
  BuildContext context, {
  required String title,
  required String message,
  String buttonText = "OK",
  VoidCallback? onOkPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => EqAlertDialog(
      title: title,
      message: message,
      buttonText: buttonText,
      onOkPressed: onOkPressed,
    ),
  );
}
