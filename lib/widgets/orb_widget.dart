import 'package:flutter/material.dart';

class OrbWidget extends StatelessWidget {
  const OrbWidget({super.key, this.size = 48, this.withGlow = true, this.pulse = false});

  final double size;
  final bool withGlow;
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    final inner = (size * 0.26).clamp(8.0, size);
    final orb = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.15, -0.22),
          radius: 0.95,
          colors: [Color(0xFFFFF4CC), Color(0xFFFFD875), Color(0xFFE8B84A), Color(0xFFC9972A)],
          stops: [0.0, 0.22, 0.55, 0.85],
        ),
        boxShadow: withGlow
            ? [
                BoxShadow(
                  color: const Color(0xFFE8B84A).withValues(alpha: 0.5),
                  blurRadius: size * 0.42,
                  offset: Offset(0, size * 0.14),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Container(
          width: inner,
          height: inner,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: Alignment(-0.1, -0.2),
              colors: [Color(0xFFFFFFFF), Color(0xFFFFE8A3), Color(0xFFE8B84A)],
            ),
          ),
        ),
      ),
    );
    if (!pulse) return orb;
    return _Pulse(child: orb);
  }
}

class _Pulse extends StatefulWidget {
  const _Pulse({required this.child});
  final Widget child;

  @override
  State<_Pulse> createState() => _PulseState();
}

class _PulseState extends State<_Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);
  late final Animation<double> _s = Tween(begin: 1.0, end: 1.06).animate(
    CurvedAnimation(parent: _c, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _s, child: widget.child);
  }
}
