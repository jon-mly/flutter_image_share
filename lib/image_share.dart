import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageShare {
  static const MethodChannel _channel = const MethodChannel('image_share');

  static Future<void> shareImage({@required String filePath}) async {
    final ByteData bytes = await rootBundle.load(filePath);
    final Uint8List list = bytes.buffer.asUint8List();
    final fileName = 'shared_' + filePath.split('/').last;
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/$fileName').create();
    file.writeAsBytesSync(list);

    _channel.invokeMethod('shareFile', '$fileName');
  }
}
