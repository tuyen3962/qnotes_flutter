import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qnotes_flutter/base/widget/base_controller.dart';
import 'package:qnotes_flutter/config/service/account_service.dart';
import 'package:qnotes_flutter/config/service/app_service.dart';
import 'package:qnotes_flutter/router/app_route_constant.dart';
import 'package:qnotes_flutter/screen/splash/splash_screen.dart';

class SplashController extends BaseController<SplashScreenState> {
  late final AccountService accountService = locator.get();
  final isScale = ValueNotifier<bool>(false);

  SplashController(super.state) {
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => isScale.value = true);
    initService();
  }

  initService() async {
    await Future.delayed(const Duration(seconds: 1))
        .then((value) => goToOnboardingPage());
  }

  goToOnboardingPage() {}

  @override
  List<ValueNotifier> get notifiers => [isScale];
}
