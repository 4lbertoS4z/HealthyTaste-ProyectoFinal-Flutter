import 'package:shared_preferences/shared_preferences.dart';

class FirstFavoritesService {
  final Set<int> _favoriteIds = {};

  Set<int> get favoriteIds => _favoriteIds;

  void toggleFavorite(int id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    // Aquí podrías llamar a un método para guardar los favoritos
  }

  bool isFavorite(int id) {
    return _favoriteIds.contains(id);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdList = prefs.getStringList('first_favorites') ?? [];
    _favoriteIds
      ..clear()
      ..addAll(favoriteIdList.map((id) => int.parse(id)));
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idList = _favoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('first_favorites', idList);
  }
}
