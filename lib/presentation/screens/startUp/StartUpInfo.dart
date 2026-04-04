import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

/// This model is the final clean object that the UI reads.
///
/// It contains:
/// - readable location fields
/// - local time
/// - day or night information
/// Main weather model that contains all weather and location information
class StartupInfo {
  // Location information
  final String landmarkOrCircle;
  final String area;
  final String city;
  final String state;
  final String country;
  final String fullAddress;

  // Time information
  final String timezone;
  final String timezoneAbbreviation;
  final String localTime;

  // Weather information
  final bool isDay;
  final String temperature;

  // Outfit suggestion (will come from backend API)
  String outfitSuggestion;

  StartupInfo({
    required this.landmarkOrCircle,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
    required this.fullAddress,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.localTime,
    required this.isDay,
    required this.temperature,
    this.outfitSuggestion = '', // Initialize as empty, will be updated
  });

  String get dayNightText => isDay ? 'Day' : 'Night';

  /// Helper method to get weather condition (sunny/cloudy/rainy etc.)
  /// For now, we derive from temperature and time of day
  /// Later this will come from actual weather API
  String get weatherCondition {
    final temp = double.tryParse(temperature) ?? 25;
    if (isDay) {
      if (temp > 25) return 'Sunny';
      if (temp > 15) return 'Pleasant';
      return 'Cool';
    } else {
      if (temp > 20) return 'Warm Night';
      if (temp > 10) return 'Cool Night';
      return 'Cold Night';
    }
  }

  // Convert to JSON for caching
  Map<String, dynamic> toJson() => {
        'landmarkOrCircle': landmarkOrCircle,
        'area': area,
        'city': city,
        'state': state,
        'country': country,
        'fullAddress': fullAddress,
        'timezone': timezone,
        'timezoneAbbreviation': timezoneAbbreviation,
        'localTime': localTime,
        'isDay': isDay,
        'temperature': temperature,
        'outfitSuggestion': outfitSuggestion,
      };

  // Create from JSON
  factory StartupInfo.fromJson(Map<String, dynamic> json) {
    return StartupInfo(
      landmarkOrCircle: json['landmarkOrCircle'] as String,
      area: json['area'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      fullAddress: json['fullAddress'] as String,
      timezone: json['timezone'] as String,
      timezoneAbbreviation: json['timezoneAbbreviation'] as String,
      localTime: json['localTime'] as String,
      isDay: json['isDay'] as bool,
      temperature: json['temperature'] as String,
      outfitSuggestion: json['outfitSuggestion'] as String? ?? '',
    );
  }
}

/// Service layer used by Flutter UI.
///
/// What it does:
/// 1. Gets the current GPS location from the device.
/// 2. Calls Open-Meteo for local time + is_day.
/// 3. Calls OpenStreetMap Nominatim for readable address details.
/// 4. Returns one clean StartupInfo object back to the home page.

class StartupInfoService {
  Future<StartupInfo> fetchStartupInfo() async {
    final position = await _getCurrentLocation();

    final weatherData = await _fetchWeatherData(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    final addressData = await _fetchReadableAddress(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    final Map<String, dynamic> current = weatherData['current'] is Map
        ? Map<String, dynamic>.from(weatherData['current'])
        : {};

    // 🔥 BigDataCloud parsing
    final landmarkOrCircle = addressData['locality'] ??
        addressData['principalSubdivision'] ??
        'Unknown place';

    final area =
        addressData['locality'] ?? addressData['city'] ?? 'Unknown area';

    final city =
        addressData['city'] ?? addressData['locality'] ?? 'Unknown city';

    final state = addressData['principalSubdivision'] ?? 'Unknown state';

    final country = addressData['countryName'] ?? 'Unknown country';

    final fullAddress = [
      addressData['locality'],
      addressData['city'],
      addressData['principalSubdivision'],
      addressData['countryName'],
    ].where((e) => e != null && e.toString().isNotEmpty).join(', ');

    final localTime = _cleanDateTimeText(current['time'] ?? '');

    return StartupInfo(
      landmarkOrCircle: landmarkOrCircle,
      area: area,
      city: city,
      state: state,
      country: country,
      fullAddress: fullAddress,
      timezone: weatherData['timezone'] ?? 'Unknown',
      timezoneAbbreviation: weatherData['timezone_abbreviation'] ?? '',
      localTime: localTime,
      isDay: ((current['is_day'] ?? 0) as num).toInt() == 1,
      temperature: (current['temperature_2m'] ?? '').toString(),
    );
  }

  // ✅ Open-Meteo (FREE)
  Future<Map<String, dynamic>> _fetchWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.https(
      'api.open-meteo.com',
      '/v1/forecast',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,is_day',
        'timezone': 'auto',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Weather API error');
    }

    return jsonDecode(response.body);
  }

  // ✅ BigDataCloud (NO 403 EVER)
  Future<Map<String, dynamic>> _fetchReadableAddress({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      'https://api.bigdatacloud.net/data/reverse-geocode-client'
      '?latitude=$latitude&longitude=$longitude&localityLanguage=en',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Location API error');
    }

    return jsonDecode(response.body);
  }

  Future<Position> _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Please enable location services');
    }

    // Check and request permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }
    // Use default settings (works with all versions)
    return await Geolocator.getCurrentPosition();
  }

  String _cleanDateTimeText(String value) {
    if (value.isEmpty) return 'Unknown';
    return value.replaceFirst('T', ' ');
  }
}
