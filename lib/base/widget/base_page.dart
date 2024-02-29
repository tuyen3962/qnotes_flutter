import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:base_flutter_source/base/widget/base_controller.dart';
import 'package:base_flutter_source/main.dart';
import 'package:base_flutter_source/widget/appbar_custom.dart';

abstract class BasePageState<S extends StatefulWidget, C extends BaseController>
    extends State<S> with WidgetsBindingObserver {
  late final C controller;

  C initController();

  bool get isResizeToAvoidBottomInset => true;

  final _keyboardDissmissPaddingNotifier = ValueNotifier<double>(0.0);

  Color get backgroundColor => appTheme.background;

  bool get isSafeArea => true;

  bool get showBack => true;

  String get title => '';

  bool? isTopSafeArea;
  bool? isBottomSafeArea;
  bool? isRightSafeArea;
  bool? isLeftSafeArea;

  @override
  void initState() {
    controller = initController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!isResizeToAvoidBottomInset) {
      /// this mean keyboard appear
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
        Future.delayed(const Duration(milliseconds: 150)).then((value) =>
            _keyboardDissmissPaddingNotifier.value =
                MediaQuery.of(context).viewInsets.bottom);
      } else {
        _keyboardDissmissPaddingNotifier.value = 0;
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  void dispose() {
    controller.onDispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _keyboardDissmissPaddingNotifier,
      builder: (context, bottomPadding, child) => Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
        body: WillPopScope(
          onWillPop: handleBackEvent,
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: Stack(
                children: [
                  SafeArea(
                    left: isLeftSafeArea ?? isSafeArea,
                    right: isRightSafeArea ?? isSafeArea,
                    top: isTopSafeArea ?? isSafeArea,
                    bottom: isBottomSafeArea ?? isSafeArea,
                    child: Column(
                      children: [
                        buildAppbar(),
                        Expanded(child: buildBody()),
                        buildBottomView(),
                        SizedBox(height: bottomPadding),
                      ],
                    ),
                  ),
                  ...buildBackgroundView(),
                ],
              )),
        ),
      ),
    );
  }

  Future<bool> handleBackEvent() async {
    return true;
  }

  List<Widget> buildBackgroundView() => [];

  Widget buildAppbar() => AppBarCustom(title: title, showBack: showBack);

  Widget buildBody() => Container();

  Widget buildBottomView() => const SizedBox();
}
