import 'package:flutter/material.dart';
import 'package:base_flutter_source/base/widget/base_page.dart';
import 'package:base_flutter_source/extension.dart';
import 'package:base_flutter_source/main.dart';
import 'package:base_flutter_source/screen/splash/splash_controller.dart';
import 'package:base_flutter_source/config/theme/base_app_theme.dart';
import 'package:base_flutter_source/utils/assets/images_asset.dart';
import 'package:base_flutter_source/widget/image_asset_custom.dart';

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
