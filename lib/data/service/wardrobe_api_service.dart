import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wardrobe_item.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class WardrobeApiService {
  final http.Client client;
  final String baseUrl;

  WardrobeApiService({
    required this.client,
    required this.baseUrl,
  });

  Future<List<WardrobeItem>> fetchWardrobeItems() async {
    final response = await client.get(
      Uri.parse('$baseUrl/wardrobe/items'),
      headers: const {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ApiException("Server error: ${response.statusCode}");
    }

    final data = jsonDecode(response.body);

    if (data is! List) {
      throw const ApiException("Invalid response format");
    }

    return data
        .map((e) => WardrobeItem.fromJson(e))
        .toList();
  }
}