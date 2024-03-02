import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qnotes_flutter/base/widget/base_page.dart';
import 'package:qnotes_flutter/extension.dart';
import 'package:qnotes_flutter/main.dart';
import 'package:qnotes_flutter/screen/preview_image/preview_image_controller.dart';
import 'package:qnotes_flutter/screen/preview_image/preview_image_parameter.dart';

class PreviewImagePage extends StatefulWidget {
  const PreviewImagePage({required this.parameter, super.key});

  final PreviewImageParameter parameter;

  @override
  State<PreviewImagePage> createState() => PreviewImagePageState();
}

class PreviewImagePageState
    extends BasePageState<PreviewImagePage, PreviewImageController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(
          controller.parameter.file,
          width: double.infinity,
          height: double.infinity,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomPreviewButton())
      ],
    );
  }

  _buildBottomPreviewButton() {
    return Container(
      color: appTheme.blackColor,
      padding: padding(all: 12),
      child: SafeArea(
        left: false,
        right: false,
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => context.pop(false),
                child: Icon(Icons.close, color: appTheme.whiteText, size: 32)),
            GestureDetector(
                onTap: () => context.pop(true),
                child: Icon(Icons.check, color: appTheme.whiteText, size: 32)),
          ],
        ),
      ),
    );
  }

  @override
  PreviewImageController initController() =>
      PreviewImageController(this, parameter: widget.parameter);
}
