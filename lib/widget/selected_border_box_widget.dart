import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:base_flutter_source/extension.dart';
import 'package:base_flutter_source/config/theme/style/style_theme.dart';
import 'package:base_flutter_source/main.dart';

class SelectedBorderBoxWidget extends StatelessWidget {
  const SelectedBorderBoxWidget({
    super.key,
    required this.context,
    required this.icons,
    required this.text,
    required this.onTap,
    this.width = 3,
    this.padding = 16,
    this.textStyle,
  });

  final BuildContext context;
  final String icons;
  final String text;
  final double width;
  final VoidCallback onTap;
  final double padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(color: appTheme.greyscale200Color),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icons),
            SizedBox(width: 12.w),
            Text(text,
                style: textStyle ?? StyleThemeData.styleSize14Weight700()),
          ],
        ),
      ),
    );
  }
}
