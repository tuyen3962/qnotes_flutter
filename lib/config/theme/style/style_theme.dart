import 'package:flutter/material.dart';
import 'package:base_flutter_source/extension.dart';
import 'package:base_flutter_source/main.dart';

class StyleThemeData {
  static TextStyle styleSize10Weight400({Color? color}) => TextStyle(
        fontSize: 10.fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize10Weight600(
          {BuildContext? context, Color? color, double height = 1.5}) =>
      TextStyle(
        fontSize: 10.fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? appTheme.blackColor,
        height: height.h,
      );

  static TextStyle styleSize11Weight600(
          {BuildContext? context, Color? color}) =>
      TextStyle(
        fontSize: 11.fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
        letterSpacing: -0.2,
      );

  static TextStyle styleSize12Weight400(
          {BuildContext? context, Color? color, double height = 1.5}) =>
      TextStyle(
        fontSize: 12.fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? appTheme.blackColor,
        height: height.h,
      );

  static TextStyle styleSize12Weight500(
          {BuildContext? context, Color? color}) =>
      TextStyle(
        fontSize: 12.fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize12Weight600(
          {BuildContext? context, Color? color}) =>
      TextStyle(
        fontSize: 12.fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize12Weight700({Color? color}) => TextStyle(
        fontSize: 12.fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize14Weight400({Color? color}) => TextStyle(
        fontSize: 14.fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize14Weight500({Color? color}) => TextStyle(
        fontSize: 14.fontSize,
        fontWeight: FontWeight.w500,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize14Weight600({Color? color}) => TextStyle(
        fontSize: 14.fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );
  static TextStyle styleSize14Weight700({Color? color}) => TextStyle(
        fontSize: 14.fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize16Weight400(
          {BuildContext? context, Color? color}) =>
      TextStyle(
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
        letterSpacing: 0.2,
      );

  static TextStyle styleSize16Weight600(
          {BuildContext? context, Color? color, double height = 1.5}) =>
      TextStyle(
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? appTheme.blackColor,
        height: height.h,
      );

  static TextStyle styleSize16Weight700(
          {BuildContext? context, Color? color, double height = 1.5}) =>
      TextStyle(
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? appTheme.blackColor,
        height: height.h,
      );

  static TextStyle styleSize18Weight600({Color? color}) => TextStyle(
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize24Weight700({Color? color}) => TextStyle(
        fontSize: 24.fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );

  static TextStyle styleSize28Weight700({Color? color}) => TextStyle(
        fontSize: 28.fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? appTheme.blackColor,
        height: 1.5.h,
      );
}
