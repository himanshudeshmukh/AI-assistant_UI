import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class RecentCard extends StatelessWidget {
  final String label;
  final String ago;
  final String kind;
  final bool dot;

  const RecentCard({
    super.key,
    required this.label,
    required this.ago,
    required this.kind,
    this.dot = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    switch (kind) {
      case 'blazer':
        iconWidget = SizedBox(
          width: 26,
          height: 26,
          child: CustomPaint(painter: _BlazerPainter()),
        );
        break;
      case 'suit':
        iconWidget = SizedBox(
          width: 24,
          height: 24,
          child: CustomPaint(painter: _SuitPainter()),
        );
        break;
      case 'trousers':
        iconWidget = SizedBox(
          width: 22,
          height: 22,
          child: CustomPaint(painter: _TrousersPainter()),
        );
        break;
      default:
        iconWidget = const SizedBox.shrink();
    }

    return Container(
      width: 86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 44,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF0F1F7), Color(0xFFD4D5DE)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Center(
              child: Stack(
                children: [
                  iconWidget,
                  if (dot)
                    Positioned(
                      bottom: 3,
                      right: 3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                    letterSpacing: -0.01,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  ago,
                  style: const TextStyle(
                    fontSize: 7,
                    color: AppColors.slate,
                    letterSpacing: 0.04,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BlazerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.navy.withOpacity(0.55);
    final path = Path()
      ..moveTo(size.width * 0.22, size.height * 0.95)
      ..lineTo(size.width * 0.30, size.height * 0.40)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.34,
        size.width * 0.70,
        size.height * 0.40,
      )
      ..lineTo(size.width * 0.78, size.height * 0.95)
      ..close();
    canvas.drawPath(path, paint);

    final paint2 = Paint()..color = Colors.white.withOpacity(0.85);
    final path2 = Path()
      ..moveTo(size.width * 0.42, size.height * 0.42)
      ..lineTo(size.width * 0.50, size.height * 0.60)
      ..lineTo(size.width * 0.58, size.height * 0.42)
      ..close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.navy.withOpacity(0.55);
    final path = Path()
      ..moveTo(size.width * 0.28, size.height * 0.30)
      ..lineTo(size.width * 0.45, size.height * 0.20)
      ..lineTo(size.width * 0.50, size.height * 0.28)
      ..lineTo(size.width * 0.55, size.height * 0.20)
      ..lineTo(size.width * 0.72, size.height * 0.30)
      ..lineTo(size.width * 0.72, size.height * 0.95)
      ..lineTo(size.width * 0.28, size.height * 0.95)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrousersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.navy.withOpacity(0.7);
    final path = Path()
      ..moveTo(size.width * 0.30, size.height * 0.22)
      ..lineTo(size.width * 0.70, size.height * 0.22)
      ..lineTo(size.width * 0.68, size.height * 0.55)
      ..lineTo(size.width * 0.60, size.height * 0.95)
      ..lineTo(size.width * 0.48, size.height * 0.95)
      ..lineTo(size.width * 0.50, size.height * 0.58)
      ..lineTo(size.width * 0.48, size.height * 0.58)
      ..lineTo(size.width * 0.50, size.height * 0.95)
      ..lineTo(size.width * 0.40, size.height * 0.95)
      ..lineTo(size.width * 0.32, size.height * 0.55)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OccasionIcon extends StatelessWidget {
  final String id;
  final bool active;

  const OccasionIcon({super.key, required this.id, required this.active});

  @override
  Widget build(BuildContext context) {
    final Color strokeColor = active ? AppColors.gold : AppColors.navy;
    final Color fillColor = active ? AppColors.gold : Colors.transparent;

    Widget icon;
    switch (id) {
      case 'date':
        icon = Icon(Icons.favorite, size: 18, color: fillColor);
        break;
      case 'party':
        icon = Icon(Icons.star, size: 18, color: strokeColor);
        break;
      case 'meeting':
        icon = Icon(Icons.business_center, size: 18, color: strokeColor);
        break;
      case 'wedding':
        icon = Icon(Icons.people, size: 18, color: strokeColor);
        break;
      case 'dinner':
        icon = Icon(Icons.restaurant, size: 18, color: strokeColor);
        break;
      case 'vacation':
        icon = Icon(Icons.beach_access, size: 18, color: strokeColor);
        break;
      case 'office':
        icon = Icon(Icons.work, size: 18, color: strokeColor);
        break;
      case 'custom':
        icon = Icon(Icons.add, size: 18, color: AppColors.navy);
        break;
      default:
        icon = const SizedBox.shrink();
    }
    return icon;
  }
}

class PieceThumb extends StatelessWidget {
  final String label;
  final String kind;
  final bool missing;

  const PieceThumb({
    super.key,
    required this.label,
    required this.kind,
    this.missing = false,
  });

  @override
  Widget build(BuildContext context) {
    if (missing) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF9ED), Color(0xFFFFF0C0)],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.gold, width: 1),
          ),
          child: Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.warmLabel,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                  color: AppColors.warmLabel,
                  letterSpacing: 0.04,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget iconWidget;
    switch (kind) {
      case 'turtle':
        iconWidget = SizedBox(
          width: 22,
          height: 22,
          child: CustomPaint(painter: _TurtlePainter()),
        );
        break;
      case 'blazer':
        iconWidget = SizedBox(
          width: 22,
          height: 22,
          child: CustomPaint(painter: _BlazerPainterPieceThumb()),
        );
        break;
      case 'trousers':
        iconWidget = SizedBox(
          width: 22,
          height: 22,
          child: CustomPaint(painter: _TrousersPainterPieceThumb()),
        );
        break;
      case 'watch':
        iconWidget = SizedBox(
          width: 22,
          height: 22,
          child: CustomPaint(painter: _WatchPainter()),
        );
        break;
      default:
        iconWidget = const SizedBox.shrink();
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            iconWidget,
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
                letterSpacing: 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TurtlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF1A1410).withOpacity(0.7);
    final path = Path()
      ..moveTo(size.width * 0.28, size.height * 0.30)
      ..lineTo(size.width * 0.45, size.height * 0.20)
      ..lineTo(size.width * 0.50, size.height * 0.28)
      ..lineTo(size.width * 0.55, size.height * 0.20)
      ..lineTo(size.width * 0.72, size.height * 0.30)
      ..lineTo(size.width * 0.72, size.height * 0.95)
      ..lineTo(size.width * 0.28, size.height * 0.95)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BlazerPainterPieceThumb extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.navy.withOpacity(0.6);
    final path = Path()
      ..moveTo(size.width * 0.22, size.height * 0.95)
      ..lineTo(size.width * 0.30, size.height * 0.40)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.34,
        size.width * 0.70,
        size.height * 0.40,
      )
      ..lineTo(size.width * 0.78, size.height * 0.95)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrousersPainterPieceThumb extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF333A5E).withOpacity(0.75);
    final path = Path()
      ..moveTo(size.width * 0.30, size.height * 0.22)
      ..lineTo(size.width * 0.70, size.height * 0.22)
      ..lineTo(size.width * 0.68, size.height * 0.55)
      ..lineTo(size.width * 0.60, size.height * 0.95)
      ..lineTo(size.width * 0.48, size.height * 0.95)
      ..lineTo(size.width * 0.50, size.height * 0.58)
      ..lineTo(size.width * 0.48, size.height * 0.58)
      ..lineTo(size.width * 0.50, size.height * 0.95)
      ..lineTo(size.width * 0.40, size.height * 0.95)
      ..lineTo(size.width * 0.32, size.height * 0.55)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.18,
      paint,
    );

    final strokePaint = Paint()
      ..color = AppColors.navy.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.18,
      strokePaint,
    );

    final rectPaint = Paint()..color = AppColors.navy.withOpacity(0.5);
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.45,
        size.height * 0.30,
        size.width * 0.10,
        size.height * 0.08,
      ),
      rectPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.45,
        size.height * 0.62,
        size.width * 0.10,
        size.height * 0.08,
      ),
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
