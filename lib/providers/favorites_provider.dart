import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/restaurant.dart';

class FavoritesNotifier extends StateNotifier<List<Restaurant>> {
  final SharedPreferences prefs;
  static const String _key = 'favorites';

  FavoritesNotifier(this.prefs) : super([]) {
    _loadFavorites();
  }

  void _loadFavorites() {
    final String? favoritesJson = prefs.getString(_key);
    if (favoritesJson != null) {
      final List<dynamic> decoded = jsonDecode(favoritesJson);
      state = decoded.map((item) => Restaurant.fromJson(item)).toList();
    }
  }

  Future<void> _saveFavorites() async {
    final String encoded = jsonEncode(state.map((r) => r.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  Future<void> toggleFavorite(Restaurant restaurant) async {
    if (state.any((r) => r.id == restaurant.id)) {
      state = state.where((r) => r.id != restaurant.id).toList();
    } else {
      state = [...state, restaurant];
    }
    await _saveFavorites();
  }

  bool isFavorite(Restaurant restaurant) {
    return state.any((r) => r.id == restaurant.id);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Restaurant>>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return FavoritesNotifier(prefs);
}); 