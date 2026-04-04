import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/controller/weather_controller.dart';
import '../screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Wait for initial weather fetch (max 2 seconds)
    final controller = context.read<WeatherController>();
    await Future.wait([
      controller.loadFromCache(),
      Future.delayed(const Duration(seconds: 1)), // Minimum splash duration
    ]);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.checkroom,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Wardrobe App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Consumer<WeatherController>(
              builder: (context, controller, child) {
                if (controller.hasData) {
                  return const Text(
                    'Weather data ready!',
                    style: TextStyle(color: Colors.green),
                  );
                }
                return const Text(
                  'Loading weather data...',
                  style: TextStyle(color: Colors.grey),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
