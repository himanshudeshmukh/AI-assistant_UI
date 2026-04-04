import 'package:flutter/foundation.dart';
import '../../presentation/screens/startUp/StartUpInfo.dart';
import '../service/cache_service.dart';
import '../service/outfit_service.dart';

/// Controller that manages weather data state
/// Uses Provider for state management
class WeatherController extends ChangeNotifier {
  final StartupInfoService _service = StartupInfoService();
  final WeatherCacheService _cache = WeatherCacheService();
  final OutfitSuggestionService _outfitService = OutfitSuggestionService();

  // State variables
  StartupInfo? _currentWeather;
  bool _isLoading = false;
  bool _isFetchingSuggestion = false;
  String? _error;

  // Getters for UI to access state
  StartupInfo? get currentWeather => _currentWeather;

  bool get isLoading => _isLoading;

  bool get isFetchingSuggestion => _isFetchingSuggestion;

  String? get error => _error;

  bool get hasData => _currentWeather != null;

  WeatherController() {
    _initialize();
  }

  /// Initialize: Load from cache first (instant), then fetch fresh data
  Future<void> _initialize() async {
    // Step 1: Load cached data instantly (if available)
    await loadFromCache();

    // Step 2: Fetch fresh data in background
    await fetchFreshData();
  }

  /// Load weather data from local cache (instant display)
  Future<void> loadFromCache() async {
    final cachedData = await _cache.getCachedWeatherData();
    if (cachedData != null) {
      _currentWeather = cachedData;
      notifyListeners();
    }
  }

  /// Fetch fresh weather data from APIs
  Future<void> fetchFreshData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get fresh weather data
      final freshData = await _service.fetchStartupInfo();
      _currentWeather = freshData;
      _error = null;

      // Cache the fresh data
      await _cache.cacheWeatherData(freshData);
      notifyListeners();

      // After getting weather data, fetch outfit suggestion
      await fetchOutfitSuggestion();
    } catch (e) {
      _error = e.toString();
      // If we have cached data, keep it; otherwise show error
      if (_currentWeather == null) {
        notifyListeners();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch outfit suggestion based on current weather
  Future<void> fetchOutfitSuggestion() async {
    if (_currentWeather == null) return;

    _isFetchingSuggestion = true;
    notifyListeners();

    try {
      final suggestion =
          await _outfitService.getOutfitSuggestion(_currentWeather!);
      _currentWeather!.outfitSuggestion = suggestion;
      notifyListeners();

      // Update cache with new suggestion
      await _cache.cacheWeatherData(_currentWeather!);
    } catch (e) {
      print('Error fetching outfit suggestion: $e');
      // Set a default suggestion if backend fails
      _currentWeather!.outfitSuggestion =
          "👕 Wear comfortable clothes based on the weather";
      notifyListeners();
    } finally {
      _isFetchingSuggestion = false;
      notifyListeners();
    }
  }

  /// Manual refresh triggered by user
  Future<void> refresh() async {
    await fetchFreshData();
  }
}
