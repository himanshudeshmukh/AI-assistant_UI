import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/screens/startUp/StartUpInfo.dart';

class WeatherCacheService {
  static const String _cacheKey = 'cached_weather_data';
  static const String _cacheTimeKey = 'cached_weather_time';
  static const Duration _cacheDuration =
      Duration(minutes: 5); // Cache for 5 minutes

  Future<void> cacheWeatherData(StartupInfo info) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(info.toJson());
    await prefs.setString(_cacheKey, jsonData);
    await prefs.setInt(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<StartupInfo?> getCachedWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cacheKey);
    final cachedTime = prefs.getInt(_cacheTimeKey);

    if (cachedData == null || cachedTime == null) return null;

    // Check if cache is expired
    final cacheAge = DateTime.now().millisecondsSinceEpoch - cachedTime;
    if (cacheAge > _cacheDuration.inMilliseconds) return null;

    try {
      final jsonData = jsonDecode(cachedData) as Map<String, dynamic>;
      return StartupInfo.fromJson(jsonData);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    await prefs.remove(_cacheTimeKey);
  }
}
