import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qnotes_flutter/utils/assets/images_asset.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:qnotes_flutter/config/theme/style/style_theme.dart';
import 'package:qnotes_flutter/extension.dart';
import 'package:qnotes_flutter/main.dart';
import 'package:qnotes_flutter/router/app_route_constant.dart';
import 'package:qnotes_flutter/utils/permission_hanlder.dart';
import 'package:qnotes_flutter/widget/image_asset_custom.dart';
import 'package:qnotes_flutter/widget/primary_button.dart';

import '../screen/preview_image/preview_image_parameter.dart';

class DialogUtils {
  static showConfirmDialog({
    String? imagePath,
    String content = '',
    double? widthImage,
    double? heightImage,
    String? title,
    VoidCallback? primaryAction,
    VoidCallback? primaryActionBackResult,
    TextStyle? contentStyle,
    EdgeInsets? contentPadding,
    bool showCancelBtn = false,
    String? primaryText,
    String? outlineText,
    bool showTitle = true,
    bool showPrimaryButton = true,
  }) async {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              width: 305.w,
              decoration: BoxDecoration(
                color: appTheme.whiteText,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: padding(top: 16, right: 19),
                    child: GestureDetector(
                      onTap: () {},
                      child: ImageAssetCustom(
                        imagePath: ImagesAssets.close,
                        size: 24,
                        color: appTheme.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 305.w,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 32.h),
                          ImageAssetCustom(
                            imagePath: imagePath ?? ImagesAssets.tick,
                            width: widthImage ?? 80.w,
                            height: heightImage ?? 80.w,
                          ),
                          SizedBox(height: 24.h),
                          if (showTitle) ...[
                            Padding(
                              padding: padding(horizontal: 12),
                              child: Text(title ?? "apologize",
                                  style: StyleThemeData.styleSize18Weight600(),
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(height: 8.h)
                          ],
                          Padding(
                            padding: contentPadding ?? padding(horizontal: 24),
                            child: Text(
                              content,
                              textAlign: TextAlign.center,
                              style: contentStyle ??
                                  StyleThemeData.styleSize14Weight500(),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          if (showPrimaryButton)
                            PrimaryButton(
                              text: primaryText ?? 'comeback',
                              onTap: () {
                                if (primaryActionBackResult != null) {
                                  primaryActionBackResult();
                                } else {
                                  context.pop();
                                }
                                if (primaryAction != null) {
                                  primaryAction();
                                }
                              },
                              isFullWidth: true,
                              buttonPadding: padding(vertical: 16),
                            ),
                          if (showCancelBtn) ...[
                            SizedBox(height: 12.h),
                            Center(
                              child: GestureDetector(
                                onTap: context.pop,
                                child: Text(
                                  outlineText ?? 'cancel',
                                  style: StyleThemeData.styleSize16Weight700()
                                      .copyWith(color: appTheme.primaryColor),
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 36.h)
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // static showGenericError({String? content, VoidCallback? onClose}) async {
  //   await showInfoErrorDialog(
  //     title: 'apologize'.tr,
  //     primaryText: 'close'.tr,
  //     primaryAction: onClose,
  //     content: content ?? 'generic_error'.tr,
  //   );
  // }

  static Future<File?> showImagePickerBottomSheet(BuildContext context,
      {required void Function(File file) onGetImage,
      bool showPreviewImage = true}) async {
    Widget iconText(BuildContext context, String imagePath, String text,
        {required ImageSource imageSource}) {
      return GestureDetector(
        onTap: () async {
          var result = false;
          var mainPermission = Permission.camera;
          final cameraRequest =
              await PermissionHandler.onCheckPermission(mainPermission);
          result = cameraRequest;
          if (imageSource == ImageSource.camera) {
            result = cameraRequest;
          } else {
            if (Platform.isIOS) {
              if (cameraRequest) {
                result = await PermissionHandler.onCheckPermission(
                    Permission.photos);
                mainPermission = Permission.photos;
              } else {
                result = await PermissionHandler.onCheckPermission(
                    Permission.storage);
                mainPermission = Permission.storage;
              }
            } else {
              final android =
                  await PlatformDeviceId.deviceInfoPlugin.androidInfo;
              if (android.version.sdkInt < 33) {
                result = await PermissionHandler.onCheckPermission(
                    Permission.storage);
                mainPermission = Permission.storage;
              }
            }
          }

          if (result) {
            ImagePicker().pickImage(source: imageSource).then((value) async {
              if (value != null) {
                context.pop();
                // if (imageSource == ImageSource.gallery) {
                if (showPreviewImage) {
                  final result = await context.push(RouteName.PREVIEW_IMAGE,
                      extra: PreviewImageParameter(file: File(value.path)));
                  if ((result ?? false) == false) {
                    return;
                  }
                }
                // }
                onGetImage(File(value.path));
              } else {
                print('nothing');
              }
            });
          } else {
            navigatorKey.currentContext!.pop();
            PermissionHandler.requestPermission(mainPermission);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageAssetCustom(imagePath: imagePath, size: 20),
            SizedBox(width: 8.w),
            Text(text, style: StyleThemeData.styleSize16Weight700())
          ],
        ),
      );
    }

    return showModalBottomSheet<File>(
      context: navigatorKey.currentContext!,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (context) {
        return Container(
          padding: padding(all: 24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            iconText(context, ImagesAssets.camera, 'camera',
                imageSource: ImageSource.camera),
            SizedBox(height: 24.h),
            iconText(context, ImagesAssets.gallery, 'gallery',
                imageSource: ImageSource.gallery),
          ]),
        );
      },
    );
  }

  static showDialogWithView<T>(
      {Widget? view, void Function(T result)? handleResult}) async {
    final result = await showDialog<T>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Container(
              width: 300.w,
              padding: padding(all: 4),
              decoration: BoxDecoration(
                color: appTheme.whiteText,
                borderRadius: BorderRadius.circular(16),
              ),
              child: view),
        );
      },
    );
    if (result != null && handleResult != null) {
      handleResult(result);
    }
  }
}
