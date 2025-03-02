import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageCompressionUtil {
  static Future<File?> compressImage(File imageFile, {int quality = 60}) async {
    try {
      final directory = await getTemporaryDirectory();
      final targetPath = path.join(
          directory.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: quality,
      );

      return compressedFile != null ? File(compressedFile.path) : null;
    } catch (e) {
      print("Image compression error: $e");
      return null;
    }
  }
}
