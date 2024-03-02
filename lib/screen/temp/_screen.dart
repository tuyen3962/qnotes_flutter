import 'package:flutter/material.dart';
import 'package:qnotes_flutter/base/widget/base_page.dart';
import 'package:qnotes_flutter/screen/temp/_controller.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => ScreenState();
}

class ScreenState extends BasePageState<Screen, Controller> {
  @override
  Controller initController() => Controller(this);
}
