import 'package:flutter/material.dart';

class TriangleDecoration extends Decoration {
  const TriangleDecoration({required this.color, required this.size}) : super();

  final Color color;
  final double size;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TriangleShapePainter(color, size);
  }
}

class _TriangleShapePainter extends BoxPainter {
  _TriangleShapePainter(Color color, double size) {
    _painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    _size = size;
  }

  late final Paint _painter;
  late final double _size;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final s = configuration.size!;
    var path = Path()
      ..moveTo(s.width + offset.dx, s.height - _size + offset.dy)
      ..lineTo(s.width - _size + offset.dx, s.height + offset.dy)
      ..lineTo(s.width + offset.dx, s.height + offset.dy)
      ..lineTo(s.width + offset.dx, s.height - _size + offset.dy)
      ..close();

    canvas.drawPath(path, _painter);
  }
}
