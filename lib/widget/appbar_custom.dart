import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qnotes_flutter/config/theme/style/style_theme.dart';
import 'package:qnotes_flutter/extension.dart';
import 'package:qnotes_flutter/main.dart';

class AppBarCustom extends StatefulWidget {
  final Function? onBack;
  final String? title;
  final List<Widget>? actions;
  final bool? showBack;
  final bool? centerTitle;
  final double? height;
  final bool? hasDivider;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? backColor;
  const AppBarCustom({
    Key? key,
    this.onBack,
    this.title,
    this.actions,
    this.showBack = true,
    this.centerTitle = true,
    this.height,
    this.hasDivider = false,
    this.backgroundColor,
    this.titleStyle,
    this.backColor,
  }) : super(key: key);

  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  back() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      padding: padding(horizontal: 23, vertical: 11),
      child: Stack(children: [
        if (widget.showBack ?? true)
          GestureDetector(
            onTap: back,
            child: Icon(Icons.arrow_back_ios,
                color: widget.backColor ?? appTheme.primaryColor),
          ),
        Center(
            child: Padding(
          padding: padding(horizontal: 24),
          child: Text(
            widget.title ?? '',
            style: widget.titleStyle ??
                StyleThemeData.styleSize18Weight600(
                    color: appTheme.primaryColor),
            // TextStyle(
            //   fontSize: 28.fontSize,
            //   fontWeight: FontWeight.w700,
            //   color: appTheme.primaryColor,
            // ),
            textAlign: (widget.centerTitle ?? false)
                ? TextAlign.center
                : TextAlign.left,
          ),
        )),
        if ((widget.actions ?? []).isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.actions ?? [],
          )
        ]
      ]),
    );
  }
}
