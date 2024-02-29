import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:base_flutter_source/base/widget/base_controller.dart';
import 'package:base_flutter_source/config/service/account_service.dart';
import 'package:base_flutter_source/config/service/app_service.dart';
import 'package:base_flutter_source/router/app_route_constant.dart';
import 'package:base_flutter_source/screen/splash/splash_screen.dart';

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
