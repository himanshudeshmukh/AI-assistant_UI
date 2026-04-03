// /// [OutfitModel] - Data model for outfit/style pick cards
// ///
// /// Represents a single outfit with images, title, and description.
// /// Designed to work with both dummy data and backend API responses.
// ///
// /// Following: Data class pattern, Immutability, Serialization ready
//
// /// Outfit data model
// class OutfitModel {
//   /// Unique identifier for the outfit
//   final String id;
//
//   /// Outfit title (e.g., "Coffee Date", "Office Meeting")
//   final String title;
//
//   /// Outfit description/subtitle
//   final String description;
//
//   /// Image URL for the outfit preview
//   final String imageUrl;
//
//   /// Optional: Category or occasion
//   final String? category;
//
//   /// Optional: Rating or popularity score
//   final double? rating;
//
//   /// Creates an outfit model
//   const OutfitModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     this.category,
//     this.rating,
//   });
//
//   /// Creates a copy with optional field replacement
//   OutfitModel copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? imageUrl,
//     String? category,
//     double? rating,
//   }) {
//     return OutfitModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       imageUrl: imageUrl ?? this.imageUrl,
//       category: category ?? this.category,
//       rating: rating ?? this.rating,
//     );
//   }
//
//   /// Convert to JSON (for API requests)
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'imageUrl': imageUrl,
//       'category': category,
//       'rating': rating,
//     };
//   }
//
//   /// Create from JSON (for API responses)
//   factory OutfitModel.fromJson(Map<String, dynamic> json) {
//     return OutfitModel(
//       id: json['id'] as String,
//       title: json['title'] as String,
//       description: json['description'] as String,
//       imageUrl: json['imageUrl'] as String,
//       category: json['category'] as String?,
//       rating: (json['rating'] as num?)?.toDouble(),
//     );
//   }
//
//   @override
//   String toString() => 'OutfitModel(id: $id, title: $title)';
// }
//
// /// Dummy outfit data for testing
// ///
// /// Replace this with API calls when backend is ready
// class DummyOutfitData {
//   /// Get dummy outfit data
//   ///
//   /// Later, replace with:
//   /// ```dart
//   /// static Future<List<OutfitModel>> fetchOutfits() async {
//   ///   final response = await http.get('/api/outfits');
//   ///   return response.map((json) => OutfitModel.fromJson(json)).toList();
//   /// }
//   /// ```
//   // static List<OutfitModel> getOutfits() {
//   //   return [
//   //     OutfitModel(
//   //       id: '1',
//   //       title: 'Coffee Date',
//   //       description: 'Casual and comfortable look',
//   //       imageUrl: 'https://images.unsplash.com/photo-1574886518339-a8e21a2e27e0?w=400&h=600&fit=crop',
//   //       category: 'Casual',
//   //       rating: 4.5,
//   //     ),
//   //     OutfitModel(
//   //       id: '2',
//   //       title: 'Office Meeting',
//   //       description: 'Professional and polished style',
//   //       imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16ebc5?w=400&h=600&fit=crop',
//   //       category: 'Professional',
//   //       rating: 4.8,
//   //     ),
//   //     OutfitModel(
//   //       id: '3',
//   //       title: 'Gym Session',
//   //       description: 'Comfort and performance',
//   //       imageUrl: 'https://images.unsplash.com/photo-1506629082632-401ba5e0b721?w=400&h=600&fit=crop',
//   //       category: 'Athletic',
//   //       rating: 4.3,
//   //     ),
//   //     OutfitModel(
//   //       id: '4',
//   //       title: 'Evening Date',
//   //       description: 'Elegant and sophisticated',
//   //       imageUrl: 'https://images.unsplash.com/photo-1539689920580-e8b3c9c8e0b0?w=400&h=600&fit=crop',
//   //       category: 'Formal',
//   //       rating: 4.9,
//   //     ),
//   //     OutfitModel(
//   //       id: '5',
//   //       title: 'Weekend Shopping',
//   //       description: 'Relaxed and stylish',
//   //       imageUrl: 'https://images.unsplash.com/photo-1541099810657-8eba5ab8ca64?w=400&h=600&fit=crop',
//   //       category: 'Casual',
//   //       rating: 4.2,
//   //     ),
//   //     OutfitModel(
//   //       id: '6',
//   //       title: 'Beach Day',
//   //       description: 'Fresh and breezy vibes',
//   //       imageUrl: 'https://images.unsplash.com/photo-1523622712202-3015dc77a1f0?w=400&h=600&fit=crop',
//   //       category: 'Casual',
//   //       rating: 4.6,
//   //     ),
//   //   ];
//   // }
//
//   static List<OutfitModel> getOutfits()
//   {
//     return [
//
//     ];
//   }
//   /// Get "Today's Outfit" featured outfit
//   static OutfitModel getTodaysOutfit() {
//     return OutfitModel(
//       id: 'featured',
//       title: "Today's Outfit",
//       description: 'Perfect for a sunny day.',
//       imageUrl: 'https://images.unsplash.com/photo-1529139574829-5e67d5e79b85?w=600&h=500&fit=crop',
//       category: 'Featured',
//       rating: 5.0,
//     );
//   }
//
//   /// Get greeting message based on time of day
//   static String getGreeting(String userName) {
//     final hour = DateTime.now().hour;
//
//     if (hour < 12) {
//       return 'Good Morning, $userName';
//     } else if (hour < 18) {
//       return 'Good Afternoon, $userName';
//     } else {
//       return 'Good Evening, $userName';
//     }
//   }
// }

/// [OutfitModel] - Data model for outfit/style pick cards
///
/// Represents a single outfit with asset images, title, and description.
/// Designed to work with both dummy data and backend API responses.
///
/// Following: Data class pattern, Immutability, Serialization ready
library;


/// Outfit data model with asset image support
class OutfitModel {
  /// Unique identifier for the outfit
  final String id;

  /// Outfit title (e.g., "Coffee Date", "Office Meeting")
  final String title;

  /// Outfit description/subtitle
  final String description;

  /// Asset image path (e.g., "assets/clothes/outfit1.png")
  final String assetImage;

  /// Optional: Category or occasion
  final String? category;

  /// Optional: Rating or popularity score
  final double? rating;

  /// Creates an outfit model
  const OutfitModel({
    required this.id,
    required this.title,
    required this.description,
    required this.assetImage,
    this.category,
    this.rating,
  });

  /// Creates a copy with optional field replacement
  OutfitModel copyWith({
    String? id,
    String? title,
    String? description,
    String? assetImage,
    String? category,
    double? rating,
  }) {
    return OutfitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assetImage: assetImage ?? this.assetImage,
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }

  /// Convert to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assetImage': assetImage,
      'category': category,
      'rating': rating,
    };
  }

  /// Create from JSON (for API responses)
  factory OutfitModel.fromJson(Map<String, dynamic> json) {
    return OutfitModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      assetImage: json['assetImage'] as String,
      category: json['category'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  @override
  String toString() => 'OutfitModel(id: $id, title: $title)';
}

/// Dummy outfit data for testing
///
/// Uses asset images from the assets folder.
/// When backend is ready, replace with API calls.
class DummyOutfitData {
  /// Get dummy outfit data with asset images
  ///
  /// Asset images should be placed in:
  /// assets/images/outfit1.png
  /// assets/images/outfit2.png
  /// assets/images/outfit3.png
  /// assets/images/outfit4.png
  /// assets/images/outfit5.png
  /// assets/images/outfit6.png
  ///
  /// Later, replace with:
  /// ```dart
  /// static Future<List<OutfitModel>> fetchOutfits() async {
  ///   final response = await http.get('/api/outfits');
  ///   return response.map((json) => OutfitModel.fromJson(json)).toList();
  /// }
  /// ```
  static List<OutfitModel> getOutfits() {
    return [
      const OutfitModel(
        id: '1',
        title: 'Coffee Date',
        description: 'Casual and comfortable look',
        assetImage: 'assets/clothes/download (1).jpg',
        category: 'Casual',
        rating: 4.5,
      ),
      const OutfitModel(
        id: '2',
        title: 'Office Meeting',
        description: 'Professional and polished style',
        assetImage: 'assets/clothes/images.jpg',
        category: 'Professional',
        rating: 4.8,
      ),
      const OutfitModel(
        id: '3',
        title: 'Gym Session',
        description: 'Comfort and performance',
        assetImage: 'assets/clothes/download.jpg',
        category: 'Athletic',
        rating: 4.3,
      ),
      const OutfitModel(
        id: '4',
        title: 'Evening Date',
        description: 'Elegant and sophisticated',
        assetImage: 'assets/clothes/images (2).jpg',
        category: 'Formal',
        rating: 4.9,
      ),
      const OutfitModel(
        id: '5',
        title: 'Weekend Shopping',
        description: 'Relaxed and stylish',
        assetImage: 'assets/clothes/images (3).jpg',
        category: 'Casual',
        rating: 4.2,
      ),
      const OutfitModel(
        id: '6',
        title: 'Beach Day',
        description: 'Fresh and breezy vibes',
        assetImage: 'assets/clothes/images (4).jpg',
        category: 'Casual',
        rating: 4.6,
      ),
    ];
  }

  /// Get "Today's Outfit" featured outfit with asset image
  static OutfitModel getTodaysOutfit() {
    return const OutfitModel(
      id: 'featured',
      title: "Today's Outfit",
      description: 'Perfect for a sunny day.',
      assetImage: 'assets/clothes/download (2).jpg',
      category: 'Featured',
      rating: 5.0,
    );
  }

  /// Get greeting message based on time of day
  static String getGreeting(String userName) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning, $userName';
    } else if (hour < 18) {
      return 'Good Afternoon, $userName';
    } else {
      return 'Good Evening, $userName';
    }
  }
}