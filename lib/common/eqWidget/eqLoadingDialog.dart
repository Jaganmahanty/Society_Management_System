import 'package:flutter/material.dart';

class EqLoadingDialog extends StatelessWidget {
  final String message;

  const EqLoadingDialog({Key? key, this.message = "Please wait..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Colors.blueAccent),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// Function to show the loading dialog
void showEqLoadingDialog(BuildContext context, {String message = "Please wait..."}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent user from closing it manually
    builder: (context) => EqLoadingDialog(message: message),
  );
}

/// Function to close the loading dialog
void closeEqLoadingDialog(BuildContext context) {
  Navigator.pop(context);
}
