import 'package:flutter/material.dart';

/// Induction seal artwork (vector equivalent of product seal).
class ViSeal extends StatelessWidget {
  const ViSeal({super.key, this.size = 200});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ViSealPainter(),
    );
  }
}

class _ViSealPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.shortestSide / 2;

    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0x2EE8B84A);
    canvas.drawCircle(c, r * 0.95, ring);

    final fill = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.3, -0.5),
        radius: 1,
        colors: [Color(0xFF1E2A6B), Color(0xFF0A1133)],
      ).createShader(Rect.fromCircle(center: c, radius: r * 0.82));

    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = const LinearGradient(
        colors: [Color(0xFFF2C96B), Color(0xFFE8B84A), Color(0xFFC9972A)],
      ).createShader(Rect.fromCircle(center: c, radius: r * 0.82));

    canvas.drawCircle(c, r * 0.82, fill);
    canvas.drawCircle(c, r * 0.82, border);

    final tp = TextPainter(
      text: const TextSpan(
        text: 'V·I',
        style: TextStyle(
          fontSize: 56,
          color: Color(0xFFE8B84A),
          fontWeight: FontWeight.w400,
          letterSpacing: 3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height / 2 + 8));

    final sub = TextPainter(
      text: const TextSpan(
        text: 'MMXXV',
        style: TextStyle(fontSize: 8, color: Color(0xB8E8B84A), letterSpacing: 3, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    sub.paint(canvas, Offset(c.dx - sub.width / 2, c.dy + r * 0.35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
