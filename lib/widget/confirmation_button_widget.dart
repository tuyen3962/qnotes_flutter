import 'package:flutter/material.dart';
import 'package:qnotes_flutter/config/theme/style/style_theme.dart';
import 'package:qnotes_flutter/main.dart';

class ConfirmationButtonWidget extends StatelessWidget {
  const ConfirmationButtonWidget({
    required this.onTap,
    required this.text,
    this.padding = 16,
    this.colorBorder,
    this.textStyle,
    this.colorText,
    this.isLoading = false,
    super.key,
  });

  final Function()? onTap;
  final String text;
  final double padding;
  final Color? colorBorder;
  final TextStyle? textStyle;
  final Color? colorText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: colorBorder ?? appTheme.blackColor),
        child: isLoading == true
            ? const Center(
                child: SizedBox(
                    width: 24, height: 24, child: CircularProgressIndicator()))
            : Text(
                text,
                style: textStyle ??
                    StyleThemeData.styleSize14Weight700(
                        color: colorText ?? appTheme.whiteText),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
