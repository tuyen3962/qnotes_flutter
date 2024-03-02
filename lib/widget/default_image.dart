import 'package:flutter/material.dart';
import 'package:qnotes_flutter/utils/assets/images_asset.dart';
import 'package:qnotes_flutter/widget/image_asset_custom.dart';

class DefaultImage extends StatelessWidget {
  const DefaultImage({
    super.key,
    this.fit,
    this.size,
  });

  final double? size;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ImageAssetCustom(
      imagePath: ImagesAssets.imageIcon,
      size: size,
      boxFit: fit,
    );
  }
}
