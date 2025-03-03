import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class imgCompress {
  static Future<File?> compressImage(File imageFile, {int quality = 60}) async {
    try {
      final directory = await getTemporaryDirectory();
      final targetPath = path.join(
          directory.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
          targetPath, quality: quality, imageFile.absolute.path);

      return compressedFile != null ? File(compressedFile.path) : null;
    } catch (e) {
      print("Image compression error : $e");
      return null;
    }
  }
}
