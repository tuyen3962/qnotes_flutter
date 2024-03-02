import 'package:flutter/material.dart';
import 'package:qnotes_flutter/base/widget/base_page.dart';
import 'package:qnotes_flutter/extension.dart';
import 'package:qnotes_flutter/main.dart';
import 'package:qnotes_flutter/screen/splash/splash_controller.dart';
import 'package:qnotes_flutter/config/theme/base_app_theme.dart';
import 'package:qnotes_flutter/utils/assets/images_asset.dart';
import 'package:qnotes_flutter/widget/image_asset_custom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends BasePageState<SplashScreen, SplashController> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeUtil.themeType,
      builder: (context, val, child) => Scaffold(
        backgroundColor: appTheme.background,
        body: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: controller.isScale,
              builder: (context, value, child) => Center(
                child: AnimatedScale(
                  scale: value ? 1 : 0,
                  duration: const Duration(milliseconds: 1000),
                  child: ImageAssetCustom(
                    imagePath: val == ThemeType.dark
                        ? ImagesAssets.addGroupIcon
                        : ImagesAssets.appleIcon,
                    size: 36.w,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  SplashController initController() => SplashController(this);

  @override
  Widget buildBody() => const SizedBox();
}
