import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../screens/startUp/StartUpInfo.dart';

/// Beautiful weather card that shows weather info and outfit suggestions
class SmartWeatherCard extends StatelessWidget {
  final StartupInfo info;
  final bool isFetchingSuggestion;

  const SmartWeatherCard({
    super.key,
    required this.info,
    this.isFetchingSuggestion = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDay = info.isDay;
    final temp = double.tryParse(info.temperature.toString()) ?? 25;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDay
              ? [const Color(0xFFFFD54F), const Color(0xFFFFA000)]
              : [AppColors.authSocialLabel, const Color(0xFF1B263B)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Row 1: Weather icon, location, temperature, day/night
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AnimatedWeatherIcon(isDay: isDay),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.city,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          info.weatherCondition,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Icon(Icons.thermostat, color: Colors.white, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      "${info.temperature}°C",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Icon(
                      isDay ? Icons.wb_sunny : Icons.nightlight_round,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      info.dayNightText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(color: Colors.white54, height: 1),
            const SizedBox(height: 16),

            // Row 2: Location details
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    info.fullAddress,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Row 3: Time and timezone
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  info.localTime,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.timelapse, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  info.timezoneAbbreviation,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Row 4: Outfit suggestion section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.checkroom, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '👗 Outfit Suggestion',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (isFetchingSuggestion)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.white24,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else
                          Text(
                            info.outfitSuggestion.isNotEmpty
                                ? info.outfitSuggestion
                                : _getFallbackSuggestion(temp),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fallback suggestion if no outfit data is available
  String _getFallbackSuggestion(double temp) {
    if (temp <= 15) return "🧥 Wear warm clothes today!";
    if (temp <= 25) return "👕 Perfect weather for casual wear";
    return "🩳 Light and breathable clothes recommended";
  }
}

/// Animated weather icon that bounces up and down
class _AnimatedWeatherIcon extends StatefulWidget {
  final bool isDay;

  const _AnimatedWeatherIcon({required this.isDay});

  @override
  State<_AnimatedWeatherIcon> createState() => _AnimatedWeatherIconState();
}

class _AnimatedWeatherIconState extends State<_AnimatedWeatherIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, sin(_controller.value * 2 * pi) * 5),
          child: Icon(
            widget.isDay ? Icons.wb_sunny : Icons.nightlight_round,
            color: Colors.white,
            size: 42,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
