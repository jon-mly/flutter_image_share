import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageShare {
  static const MethodChannel _channel = const MethodChannel('image_share');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> shareImage({@required filePath}) async {
    try {
      final ByteData bytes = await rootBundle.load(filePath);
      final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(list);

      _channel.invokeMethod('shareFile', 'image.jpg');
    } catch (e) {
      print('Share error: $e');
    }
  }
}
