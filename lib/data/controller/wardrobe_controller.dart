import 'package:flutter/material.dart';
import '../models/wardrobe_item.dart';
import '../repositories/wardrobe_repository.dart';

class WardrobeGalleryController extends ChangeNotifier {
  final WardrobeRepository repository;

  WardrobeGalleryController({required this.repository});

  final TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  List<WardrobeItem> items = [];

  List<WardrobeItem> get visibleItems {
    final query = searchController.text.toLowerCase();
    return items.where((item) {
      return query.isEmpty || item.matchesQuery(query);
    }).toList();
  }

  Future<void> load() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      items = await repository.fetchWardrobeItems();

    } catch (e) {
      errorMessage = "Failed to load data. Check internet.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onSearchChanged(String value) {
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}