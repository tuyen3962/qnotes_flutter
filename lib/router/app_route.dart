import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:base_flutter_source/main.dart';
import 'package:base_flutter_source/router/app_route_constant.dart';
import 'package:base_flutter_source/screen/home/home_page.dart';
import 'package:base_flutter_source/screen/preview_image/preview_image_page.dart';
import 'package:base_flutter_source/screen/preview_image/preview_image_parameter.dart';
import 'package:base_flutter_source/screen/splash/splash_screen.dart';

class AppRoute {
  static final mainRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RouteName.SPLASH,
    routes: <RouteBase>[
      GoRoute(
        path: RouteName.SPLASH,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.PREVIEW_IMAGE,
        builder: (context, state) {
          return PreviewImagePage(
              parameter: state.extra as PreviewImageParameter);
        },
      ),
    ],
  );
}
