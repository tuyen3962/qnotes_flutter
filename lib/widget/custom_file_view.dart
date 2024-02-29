import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base_flutter_source/widget/default_image.dart';

class CustomFileImage extends StatelessWidget {
  const CustomFileImage({
    super.key,
    this.file,
    this.byte,
    this.boxFit,
    this.height,
    this.width,
    this.size,
  });

  final File? file;
  final Uint8List? byte;
  final double? size;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return Image.file(
        file!,
        height: size ?? height,
        width: size ?? width,
        fit: boxFit,
        errorBuilder: (context, error, stackTrace) => DefaultImage(),
      );
    } else if (byte != null) {
      return Image.memory(
        byte!,
        height: size ?? height,
        width: size ?? width,
        fit: boxFit,
        errorBuilder: (context, error, stackTrace) => DefaultImage(),
      );
    }

    return SizedBox();
  }
}
