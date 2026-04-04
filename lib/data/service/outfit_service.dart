// /// [OutfitService] - Service for outfit data management
// ///
// /// Handles:
// /// - Outfit data fetching from API
// /// - Caching (optional)
// /// - Error handling
// /// - Conversion between models
// ///
// /// Following: Service pattern, Repository pattern, Separation of concerns
// library;
//
// import 'package:flutter/foundation.dart';
// import '../models/outfit_model.dart';
//
// /// Service for managing outfit data
// ///
// /// Currently uses dummy data, but ready for backend integration
// class OutfitService {
//   // ==================== Singleton ====================
//   static final OutfitService _instance = OutfitService._internal();
//
//   factory OutfitService() {
//     return _instance;
//   }
//
//   OutfitService._internal();
//
//   // ==================== Cache ====================
//   List<OutfitModel>? _cachedOutfits;
//   OutfitModel? _cachedFeaturedOutfit;
//
//   // ==================== Public Methods ====================
//
//   /// Fetches all outfit recommendations
//   ///
//   /// Returns dummy data for now.
//   /// To switch to backend:
//   ///
//   /// ```dart
//   /// Future<List<OutfitModel>> fetchOutfits() async {
//   ///   try {
//   ///     final response = await http.get(
//   ///       Uri.parse('$baseUrl/api/outfits'),
//   ///       headers: {'Authorization': 'Bearer $token'},
//   ///     );
//   ///
//   ///     if (response.statusCode == 200) {
//   ///       final List<dynamic> data = jsonDecode(response.body)['data'];
//   ///       _cachedOutfits = data
//   ///           .map((json) => OutfitModel.fromJson(json))
//   ///           .toList();
//   ///       return _cachedOutfits!;
//   ///     } else {
//   ///       throw Exception('Failed to load outfits: ${response.statusCode}');
//   ///     }
//   ///   } catch (e) {
//   ///     debugPrint('Error fetching outfits: $e');
//   ///     rethrow;
//   ///   }
//   /// }
//   /// ```
//   Future<List<OutfitModel>> fetchOutfits({bool forceRefresh = false}) async {
//     // Return cached data if available and not forcing refresh
//     if (!forceRefresh && _cachedOutfits != null) {
//       return _cachedOutfits!;
//     }
//
//     try {
//       // Simulate network delay
//       await Future.delayed(const Duration(milliseconds: 500));
//
//       // For now, return dummy data
//       _cachedOutfits = DummyOutfitData.getOutfits();
//       return _cachedOutfits!;
//
//       // TODO: Replace with actual API call
//       // final response = await http.get(...);
//       // return response.map(...).toList();
//     } catch (e) {
//       debugPrint('Error fetching outfits: $e');
//       // Return cached data on error
//       return _cachedOutfits ?? [];
//     }
//   }
//
//   /// Fetches featured outfit of the day
//   ///
//   /// Returns dummy data for now.
//   /// To switch to backend:
//   ///
//   /// ```dart
//   /// Future<OutfitModel> fetchFeaturedOutfit() async {
//   ///   try {
//   ///     final response = await http.get(
//   ///       Uri.parse('$baseUrl/api/outfits/featured'),
//   ///       headers: {'Authorization': 'Bearer $token'},
//   ///     );
//   ///
//   ///     if (response.statusCode == 200) {
//   ///       final data = jsonDecode(response.body)['data'];
//   ///       _cachedFeaturedOutfit = OutfitModel.fromJson(data);
//   ///       return _cachedFeaturedOutfit!;
//   ///     } else {
//   ///       throw Exception('Failed to load featured outfit');
//   ///     }
//   ///   } catch (e) {
//   ///     debugPrint('Error fetching featured outfit: $e');
//   ///     rethrow;
//   ///   }
//   /// }
//   /// ```
//   Future<OutfitModel> fetchFeaturedOutfit({
//     bool forceRefresh = false,
//   }) async {
//     // Return cached data if available and not forcing refresh
//     if (!forceRefresh && _cachedFeaturedOutfit != null) {
//       return _cachedFeaturedOutfit!;
//     }
//
//     try {
//       // Simulate network delay
//       await Future.delayed(const Duration(milliseconds: 500));
//
//       // For now, return dummy data
//       _cachedFeaturedOutfit = DummyOutfitData.getTodaysOutfit();
//       return _cachedFeaturedOutfit!;
//
//       // TODO: Replace with actual API call
//       // final response = await http.get(...);
//       // return OutfitModel.fromJson(...);
//     } catch (e) {
//       debugPrint('Error fetching featured outfit: $e');
//       // Return cached data on error
//       return _cachedFeaturedOutfit ?? DummyOutfitData.getTodaysOutfit();
//     }
//   }
//
//   /// Fetches outfit details by ID
//   ///
//   /// [id] - The outfit ID
//   ///
//   /// To implement with backend:
//   /// ```dart
//   /// Future<OutfitModel> fetchOutfitById(String id) async {
//   ///   try {
//   ///     final response = await http.get(
//   ///       Uri.parse('$baseUrl/api/outfits/$id'),
//   ///       headers: {'Authorization': 'Bearer $token'},
//   ///     );
//   ///
//   ///     if (response.statusCode == 200) {
//   ///       final data = jsonDecode(response.body)['data'];
//   ///       return OutfitModel.fromJson(data);
//   ///     } else {
//   ///       throw Exception('Outfit not found');
//   ///     }
//   ///   } catch (e) {
//   ///     debugPrint('Error fetching outfit: $e');
//   ///     rethrow;
//   ///   }
//   /// }
//   /// ```
//   Future<OutfitModel> fetchOutfitById(String id) async {
//     try {
//       // Simulate network delay
//       await Future.delayed(const Duration(milliseconds: 300));
//
//       // For now, return from dummy data
//       final outfits = DummyOutfitData.getOutfits();
//       final outfit = outfits.firstWhere(
//             (o) => o.id == id,
//         orElse: () => DummyOutfitData.getTodaysOutfit(),
//       );
//
//       return outfit;
//
//       // TODO: Replace with actual API call
//       // final response = await http.get(...);
//       // return OutfitModel.fromJson(...);
//     } catch (e) {
//       debugPrint('Error fetching outfit: $e');
//       rethrow;
//     }
//   }
//
//   /// Likes/bookmarks an outfit
//   ///
//   /// [id] - The outfit ID to like
//   ///
//   /// To implement with backend:
//   /// ```dart
//   /// Future<void> likeOutfit(String id) async {
//   ///   try {
//   ///     final response = await http.post(
//   ///       Uri.parse('$baseUrl/api/outfits/$id/like'),
//   ///       headers: {'Authorization': 'Bearer $token'},
//   ///     );
//   ///
//   ///     if (response.statusCode != 200) {
//   ///       throw Exception('Failed to like outfit');
//   ///     }
//   ///   } catch (e) {
//   ///     debugPrint('Error liking outfit: $e');
//   ///     rethrow;
//   ///   }
//   /// }
//   /// ```
//   Future<void> likeOutfit(String id) async {
//     try {
//       // Simulate network delay
//       await Future.delayed(const Duration(milliseconds: 300));
//
//       debugPrint('Liked outfit: $id');
//
//       // TODO: Replace with actual API call
//       // final response = await http.post(...);
//     } catch (e) {
//       debugPrint('Error liking outfit: $e');
//       rethrow;
//     }
//   }
//
//   /// Searches outfits by query
//   ///
//   /// [query] - Search query
//   ///
//   /// To implement with backend:
//   /// ```dart
//   /// Future<List<OutfitModel>> searchOutfits(String query) async {
//   ///   try {
//   ///     final response = await http.get(
//   ///       Uri.parse('$baseUrl/api/outfits/search?q=$query'),
//   ///       headers: {'Authorization': 'Bearer $token'},
//   ///     );
//   ///
//   ///     if (response.statusCode == 200) {
//   ///       final List<dynamic> data = jsonDecode(response.body)['data'];
//   ///       return data
//   ///           .map((json) => OutfitModel.fromJson(json))
//   ///           .toList();
//   ///     } else {
//   ///       throw Exception('Search failed');
//   ///     }
//   ///   } catch (e) {
//   ///     debugPrint('Error searching outfits: $e');
//   ///     rethrow;
//   ///   }
//   /// }
//   /// ```
//   Future<List<OutfitModel>> searchOutfits(String query) async {
//     try {
//       // Simulate network delay
//       await Future.delayed(const Duration(milliseconds: 500));
//
//       // For now, filter dummy data
//       final allOutfits = DummyOutfitData.getOutfits();
//       final filtered = allOutfits
//           .where(
//             (o) =>
//         o.title.toLowerCase().contains(query.toLowerCase()) ||
//             o.description.toLowerCase().contains(query.toLowerCase()),
//       )
//           .toList();
//
//       return filtered;
//
//       // TODO: Replace with actual API call
//       // final response = await http.get(...);
//       // return response.map(...).toList();
//     } catch (e) {
//       debugPrint('Error searching outfits: $e');
//       return [];
//     }
//   }
//
//   /// Filters outfits by category
//   ///
//   /// [category] - The category to filter by
//   ///
//   /// To implement with backend:
//   /// ```dart
//   /// Future<List<OutfitModel>> filterByCategory(String category) async {
//   ///   try {
//   ///     final response = await http.get(
//   ///       Uri.parse('$baseUrl/api/outfits?category=$category'),
//   ///       headers: {'Authorization': 'Bearer $token'},
//   ///     );
//   ///
//   ///     if (response.statusCode == 200) {
//   ///       final List<dynamic> data = jsonDecode(response.body)['data'];
//   ///       return data
//   ///           .map((json) => OutfitModel.fromJson(json))
//   ///           .toList();
//   ///     } else {
//   ///       throw Exception('Filter failed');
//   ///     }
//   ///   } catch (e) {
//   ///     debugPrint('Error filtering outfits: $e');
//   ///     rethrow;
//   ///   }
//   /// }
//   /// ```
//   Future<List<OutfitModel>> filterByCategory(String category) async {
//     try {
//       // Simulate network delay
//       await Future.delayed(const Duration(milliseconds: 500));
//
//       // For now, filter dummy data
//       final allOutfits = DummyOutfitData.getOutfits();
//       final filtered = allOutfits
//           .where((o) => o.category?.toLowerCase() == category.toLowerCase())
//           .toList();
//
//       return filtered;
//
//       // TODO: Replace with actual API call
//       // final response = await http.get(...);
//       // return response.map(...).toList();
//     } catch (e) {
//       debugPrint('Error filtering outfits: $e');
//       return [];
//     }
//   }
//
//   /// Clears all cached data
//   ///
//   /// Useful when:
//   /// - User logs out
//   /// - User wants to refresh all data
//   /// - Clearing old cached data
//   void clearCache() {
//     _cachedOutfits = null;
//     _cachedFeaturedOutfit = null;
//     debugPrint('Outfit cache cleared');
//   }
//
//   /// Refreshes all data
//   ///
//   /// Fetches both outfits and featured outfit
//   Future<void> refreshAll() async {
//     try {
//       await Future.wait([
//         fetchOutfits(forceRefresh: true),
//         fetchFeaturedOutfit(forceRefresh: true),
//       ]);
//       debugPrint('All outfit data refreshed');
//     } catch (e) {
//       debugPrint('Error refreshing outfit data: $e');
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../presentation/screens/startUp/StartUpInfo.dart';

/// Service to get outfit suggestions based on weather data
/// This will call your backend API
class OutfitSuggestionService {
  // TODO: Replace with your actual backend URL
  static const String _baseUrl = 'https://your-backend-api.com';

  /// For now, return static suggestions based on weather
  /// Later, this will make an actual API call to your backend
  Future<String> getOutfitSuggestion(StartupInfo weatherInfo) async {
    // Static suggestions for now (based on weather)
    // This acts as a fallback when backend is not available

    final temp = double.tryParse(weatherInfo.temperature) ?? 25;
    final isDay = weatherInfo.isDay;
    final condition = weatherInfo.weatherCondition;

    // Detailed static suggestions
    String suggestion = _getStaticSuggestion(temp, isDay, condition);

    // TODO: Uncomment this when your backend API is ready
    /*
    try {
      final suggestion = await _fetchFromBackend(weatherInfo);
      return suggestion;
    } catch (e) {
      print('Backend API error: $e, using static suggestion');
      return _getStaticSuggestion(temp, isDay, condition);
    }
    */

    return suggestion;
  }

  /// Static suggestions based on weather parameters
  String _getStaticSuggestion(double temp, bool isDay, String condition) {
    if (temp <= 5) {
      return "❄️ Extreme cold weather! Wear thermal wear, heavy winter jacket, woolen cap, scarf, gloves, and insulated boots. Layer up with sweaters.";
    } else if (temp <= 10) {
      return "🧥 Very cold! Wear a heavy winter coat, warm sweater, thermal innerwear, scarf, and gloves. Don't forget warm socks and boots.";
    } else if (temp <= 15) {
      return "🧣 Cold day ahead! Wear a thick jacket or woolen coat over a sweater. Add a scarf for extra warmth. Perfect for layering.";
    } else if (temp <= 20) {
      return "🍂 Cool weather! A light jacket, hoodie, or denim jacket will work perfectly. Pair with jeans or chinos.";
    } else if (temp <= 25) {
      return "🌤️ Pleasant weather! Wear a light sweater, long-sleeve shirt, or light jacket. Comfortable jeans or trousers would be great.";
    } else if (temp <= 30) {
      if (isDay) {
        return "☀️ Warm sunny day! Wear cotton t-shirt, shorts, or light dresses. Don't forget sunglasses and sunscreen!";
      } else {
        return "🌙 Warm evening! Light cotton clothes, short sleeves, or summer dresses. Perfect for outdoor activities.";
      }
    } else if (temp <= 35) {
      return "🔥 Hot day! Wear breathable fabrics like cotton or linen. Light colors recommended. Stay hydrated and use sun protection.";
    } else {
      return "🥵 Extremely hot! Wear minimal, loose-fitting light-colored clothes. Stay indoors if possible. Keep yourself hydrated!";
    }
  }

  /// Future backend API call (ready when you have the endpoint)
  Future<String> _fetchFromBackend(StartupInfo weatherInfo) async {
    // Prepare the request body with weather data
    final requestBody = {
      'temperature': weatherInfo.temperature,
      'isDay': weatherInfo.isDay,
      'condition': weatherInfo.weatherCondition,
      'city': weatherInfo.city,
      'time': weatherInfo.localTime,
    };

    // Make POST request to your backend
    final response = await http.post(
      Uri.parse('$_baseUrl/api/outfit-suggestion'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['suggestion'] as String;
    } else {
      throw Exception('Failed to get outfit suggestion');
    }
  }
}
