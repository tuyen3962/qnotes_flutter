import 'package:flutter/material.dart';
import 'package:base_flutter_source/base/stream/base_stream_controller.dart';

class BaseStreamBuilder<T> extends StatelessWidget {
  const BaseStreamBuilder({super.key, required this.controller, this.builder});
  final BaseStreamController controller;
  final Widget Function(T value)? builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: key,
      stream: controller.stream,
      initialData: controller.value,
      builder: (context, snapshot) {
        return builder?.call(snapshot.data ?? controller.value) ?? SizedBox();
      },
    );
  }
}

class TwoBaseStreamBuilder<A, B> extends StatelessWidget {
  const TwoBaseStreamBuilder(
      {super.key,
      required this.firstController,
      required this.secondController,
      this.builder});

  final BaseStreamController firstController;
  final BaseStreamController secondController;
  final Widget Function(A firstValue, B secondVal)? builder;

  @override
  Widget build(BuildContext context) {
    return BaseStreamBuilder<A>(
      controller: firstController,
      builder: (firstVal) => BaseStreamBuilder<B>(
        controller: secondController,
        builder: (value) => builder?.call(firstVal, value) ?? SizedBox(),
      ),
    );
  }
}
