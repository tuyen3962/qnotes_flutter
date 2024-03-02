import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:go_router/go_router.dart';
import 'package:qnotes_flutter/base/widget/base_page.dart';
import 'package:qnotes_flutter/config/theme/style/style_theme.dart';
import 'package:qnotes_flutter/l10n/l10n.dart';
import 'package:qnotes_flutter/main.dart';
import 'package:qnotes_flutter/screen/home/home_controller.dart';
import 'package:qnotes_flutter/utils/assets/images_asset.dart';
import 'package:qnotes_flutter/widget/image_asset_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  static HomePageState of(BuildContext context) {
    final state = context.findAncestorStateOfType<HomePageState>();

    if (state == null) {
      throw 'the home page state is not created';
    }

    return state;
  }

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage, HomeController> {
  final bottomVisible = ValueNotifier(true);

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Future<T?> onPushName<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    bottomVisible.value = false;
    final result = await context.pushNamed<T>(name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
    bottomVisible.value = true;
    return result;
  }

  Future<T?> onPush<T>(String name, {Object? extra}) async {
    bottomVisible.value = false;
    final result = await context.push<T>(name, extra: extra);
    bottomVisible.value = true;
    return result;
  }

  @override
  void dispose() {
    bottomVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomItem = [
      BottomNavItem(label: 'Employee', imagePath: ImagesAssets.emptyAvatar),
      BottomNavItem(label: 'Đo huyết áp', imagePath: ImagesAssets.camera),
      // BottomNavItem(
      //     label: context.l10n.account_text, imagePath: ImagesAssets.camera),
    ];
    return ValueListenableBuilder(
      valueListenable: bottomVisible,
      builder: (context, visible, child) => PersistentKeyboardHeightProvider(
        child: Scaffold(
          resizeToAvoidBottomInset: visible,
          body: widget.navigationShell,
          bottomNavigationBar: Visibility(
            visible: visible,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: Offset(0, -4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                onTap: _goBranch,
                fixedColor: appTheme.twoActiveColor,
                selectedLabelStyle: StyleThemeData.styleSize10Weight600(
                    color: appTheme.twoActiveColor),
                backgroundColor: appTheme.whiteText,
                unselectedItemColor: appTheme.textDesColor,
                unselectedLabelStyle: StyleThemeData.styleSize10Weight400(
                    color: appTheme.textDesColor),
                currentIndex: widget.navigationShell.currentIndex,
                items: bottomItem
                    .map((e) => BottomNavigationBarItem(
                          label: e.label,
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ImageAssetCustom(
                              imagePath: e.imagePath,
                              color: appTheme.textDesColor,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ImageAssetCustom(
                              imagePath: e.imagePath,
                              color: appTheme.twoActiveColor,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeController initController() => HomeController(this);
}

class BottomNavItem {
  final String label;
  final String imagePath;

  BottomNavItem({this.label = '', this.imagePath = ''});
}
