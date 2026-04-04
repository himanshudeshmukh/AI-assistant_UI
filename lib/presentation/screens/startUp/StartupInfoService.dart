import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'StartUpInfo.dart';

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
      fullAddress: fullAddress.isEmpty ? 'Unknown location' : fullAddress,
      timezone: weatherData['timezone'] ?? 'Unknown',
      timezoneAbbreviation: weatherData['timezone_abbreviation'] ?? '',
      localTime: localTime,
      isDay: ((current['is_day'] ?? 0) as num).toInt() == 1,
      temperature: (current['temperature_2m'] ?? '').toString(),
    );
  }

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
      throw Exception('Weather API error: ${response.statusCode}');
    }
    return jsonDecode(response.body);
  }

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
      throw Exception('Location API error: ${response.statusCode}');
    }
    return jsonDecode(response.body);
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  String _cleanDateTimeText(String value) {
    if (value.isEmpty) return 'Unknown';
    return value.replaceFirst('T', ' ');
  }
}
