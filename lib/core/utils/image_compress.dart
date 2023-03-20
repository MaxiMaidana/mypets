import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompress {
  static Future<File?> compressAndGetFile(File file, String imageName) async {
    Directory directory = await getTemporaryDirectory();
    String targetPath = '${directory.path}/$imageName.jpeg';

    if (!isJpeg(file)) {
      File? result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 50,
        rotate: 0,
      );

      return result;
    }

    if (getSize(file) >= 3) {
      File? result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 80,
        rotate: 0,
      );

      return result;
    }

    File f = await file.copy(targetPath);
    return f;
  }

  static bool isJpeg(File file) => p.extension(file.path) == '.jpeg';

  static double getSize(File file) =>
      (file.readAsBytesSync().lengthInBytes / 1024) / 1024;
}
