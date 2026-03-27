import '../models/wardrobe_item.dart';
import '../service/wardrobe_api_service.dart';

class WardrobeRepository {
  final WardrobeApiService apiService;

  WardrobeRepository({required this.apiService});

  Future<List<WardrobeItem>> fetchWardrobeItems() async {
    return await apiService.fetchWardrobeItems();
  }
}