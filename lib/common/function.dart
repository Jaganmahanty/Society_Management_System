// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison, prefer_if_null_operators, prefer_const_constructors, deprecated_member_use, prefer_is_empty, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:society_management_system/common/global_section/colors.dart';

// Proggress Indicator widget ..
CircularProgressIndicator showLoading() {
  return CircularProgressIndicator(
    backgroundColor: primaryColor,
    color: Colors.white,
    strokeWidth: 8,
  );
}

LoadingIndicator Indicate(context) {
  return LoadingIndicator(
    colors: colorRange,
    indicatorType: Indicator.values[3],
    strokeWidth: 3,
    // pause: pause,
    // pathBackgroundColor: Colors.black45,
  );
}

// To display progress indicator ..
void showProgressIndicator(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(child: showLoading());
      });
}

void customProgress(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          height: 80,
          width: 80,
          child: Center(
            child: LoadingIndicator(
                colors: colorRange,
                indicatorType: Indicator.values[17],
                strokeWidth: 30),
          ),
        ),
      );
    },
  );
}

List<Color> colorRange = [
  // Colors.indigo,
  // Colors.indigo.shade400,
  // Colors.indigo.shade200,`
  // Colors.indigo.shade50,
  Color.fromARGB(255, 8, 117, 66),
  Color.fromARGB(255, 88, 189, 157),
  Color.fromARGB(255, 129, 223, 215),
  Color.fromARGB(255, 132, 185, 181),
];

// To hide progress indicator ..
void hideIndicator(context) {
  Navigator.of(context).pop();
}

// To get value ..
Future<String> getSettings(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key).toString() == "null"
      ? ""
      : prefs.getString(key).toString();
}

// To set value ..
setSettings(key, value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

// To display snakeBar ..
showSnakebar(context, {title, milliseconds, color}) {
  final snackBar = SnackBar(
    content: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: color,
    duration: Duration(milliseconds: milliseconds),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  Future.delayed(Duration(milliseconds: milliseconds + 100))
      .then((value) => ScaffoldMessenger.of(context).hideCurrentSnackBar());
}

// To diaplay delete pop up ..
void showDeleteDialog(context,
    {String? moduleName,
    id,
    required VoidCallback onCancel,
    required VoidCallback onConfirm}) {
  Dialogs.bottomMaterialDialog(
      msg: 'Are you sure to delete this $moduleName with Id : $id?\n' +
          'You can\'t undo this action !!!',
      title: 'Delete',
      context: context,
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(BeveledRectangleBorder()),
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel, color: Colors.white),
              SizedBox(width: 15),
              Text("Cancel", style: TextStyle(color: Colors.white))
            ],
          ),
          onPressed: () {
            onCancel();
            // Navigator.pop(context);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(BeveledRectangleBorder()),
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_forever, color: Colors.white),
              SizedBox(width: 15),
              Text("Yes", style: TextStyle(color: Colors.white)),
            ],
          ),
          onPressed: () {
            onConfirm();
            //  DeleteData(id);
            // Navigator.pop(context);
          },
        ),
      ]);
}

// To diaplay delete pop up in grid ..
void showDetDeleteDialog(context,
    {String? moduleName,
    id,
    required VoidCallback onCancel,
    required VoidCallback onConfirm}) {
  Dialogs.materialDialog(
      msg: 'Are you sure to delete this item with Item #$id?\n' +
          'You can\'t undo this action !',
      title: "Delete Grid Details !!!",
      color: Colors.white,
      context: context,
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(BeveledRectangleBorder()),
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel, color: Colors.white),
              SizedBox(width: 8),
              Text("Cancel", style: TextStyle(color: Colors.white))
            ],
          ),
          onPressed: () {
            onCancel();
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(BeveledRectangleBorder()),
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_forever, color: Colors.white),
              SizedBox(width: 8),
              Text("Yes", style: TextStyle(color: Colors.white)),
            ],
          ),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
        ),
      ]);
}

List splitText(text, {bool? comma = false}) {
  var x = comma! ? text.split(',') : text.split(' ');
  List lst = [];
  //lst.add('x');
  x.forEach((k) => lst.add(k));
  // print(lst);
  return lst;
}

String sentenceCapitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

// To convert yyyy-MM-dd to dd-MM-yyy to display date to user ..
String convertViewDate(String dateStr) {
  try {
    // Parse the date from yyyy-MM-dd format
    DateTime date = DateTime.parse(dateStr);

    // Format the date to dd-MM-yyyy
    return DateFormat('dd-MM-yyyy').format(date);
  } catch (e) {
    print("Error parsing date: $e");
    return dateStr;
  }
}

//For print full long json into the terminal
void flutterLog(String json) {
  const int chunkSize = 500;
  for (int i = 0; i < json.length; i += chunkSize) {
    int end = (i + chunkSize < json.length) ? i + chunkSize : json.length;
    print(json.substring(i, end));
  }
}

//For log into terminal
void flutterLogger(var json, {String? type = "d"}) {
  var logger = Logger();
  if (type == "d") {
    logger.d(json);
  } else if (type == "e") {
    logger.e(json);
  } else if (type == "f") {
    logger.f(json);
  } else if (type == "i") {
    logger.i(json);
  } else {
    logger.log(Level.warning, json);
  }
}

// To display snakeBar ..
DottedLineFun() {
  // DottedLine(
  //   direction: Axis.horizontal,
  //   alignment: WrapAlignment.center,
  //   lineLength: double.infinity,
  //   lineThickness: 1.5,
  //   dashLength: 3.0,
  //   dashColor: const Color.fromARGB(255, 177, 175, 175),
  // );
}

// To save json into local file ..
Future<String> saveJson(String jsonData, String fileName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.json';
    final file = File(filePath);
    await file.writeAsString(jsonData);
    print('JSON data saved to: $filePath');
    return filePath;
  } catch (e) {
    print('Error saving JSON data: $e');
  }
  return '';
}

// To read JSON data from a file ..
Future<String> readJson(String filename) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$filename';
    final file = File(filePath);
    String jsonData = await file.readAsString();
    return jsonData;
  } catch (e) {
    print('Error reading JSON data: $e');
    return '';
  }
}

String replaceString(String Str) {
  String result = Str.replaceAll(RegExp(r'[^\w\s]'), '_');
  return result;
}

final numFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String yesButtonText,
  required Function onYesPressed,
  String noButtonText = 'No', // Default 'No' button text
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 22),
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape:
                          MaterialStateProperty.all(BeveledRectangleBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 5),
                      Text(yesButtonText,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                    onYesPressed();
                    // Navigator.pop(context); // Close the dialog after action
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape:
                          MaterialStateProperty.all(BeveledRectangleBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel, color: Colors.white),
                      SizedBox(width: 2.4),
                      Text(noButtonText, style: TextStyle(color: Colors.white))
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Simply close the dialog
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void showAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  String buttonText = 'OK',
  VoidCallback? onButtonPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String yesButtonText,
  required String noButtonText,
  required VoidCallback onPressedYes,
  required VoidCallback onPressedNo,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(BeveledRectangleBorder()),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: onPressedYes,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 5),
                      Text(yesButtonText,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(BeveledRectangleBorder()),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: onPressedNo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel, color: Colors.white),
                      SizedBox(width: 2.4),
                      Text(noButtonText, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
