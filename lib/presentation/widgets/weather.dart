import 'package:flutter/material.dart';
import 'package:Kaivon/presentation/widgets/smart_weather_card.dart';
import 'package:provider/provider.dart';
import '../../data/controller/weather_controller.dart';

/// Main weather widget that handles loading states and displays the weather card
class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherController>(
      builder: (context, controller, child) {
        // Case 1: Weather data is available - show the card
        if (controller.hasData) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SmartWeatherCard(
                  info: controller.currentWeather!,
                  isFetchingSuggestion: controller.isFetchingSuggestion,
                ),
              ),
              const SizedBox(height: 16),
              // Calendar button

              // Small loading indicator while updating in background
              if (controller.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            ],
          );
        }

        // Case 2: First time loading (no cache yet) - show loading
        if (controller.isLoading && !controller.hasData) {
          return Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Fetching weather data...'),
                  SizedBox(height: 8),
                  Text(
                    'Please wait while we get your location',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        // Case 3: Error occurred - show error with retry button
        if (controller.error != null && !controller.hasData) {
          return _ErrorView(
            message: controller.error!,
            onRetry: () => controller.refresh(),
          );
        }

        // Default: show nothing
        return const SizedBox.shrink();
      },
    );
  }
}

/// Error widget shown when weather data fetch fails
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          Text(
            'Unable to load weather data',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(fontSize: 12, color: Colors.red.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
