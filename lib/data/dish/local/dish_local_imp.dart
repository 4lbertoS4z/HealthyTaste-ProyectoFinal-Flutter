import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DishLocalImp implements DishLocalRepository {
  final Set<int> _favoriteIds = {};

  @override
  Set<int> get favoriteIds => _favoriteIds;

  @override
  void toggleFavorite(int id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
  }

  @override
  bool isFavorite(int id) {
    return _favoriteIds.contains(id);
  }

  @override
  Future<void> loadFirstDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdList = prefs.getStringList('first_favorites') ?? [];
    _favoriteIds
      ..clear()
      ..addAll(favoriteIdList.map((id) => int.parse(id)));
  }

  @override
  Future<void> saveFirstDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idList = _favoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('first_favorites', idList);
  }

  @override
  Future<void> loadSecondsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdList = prefs.getStringList('second_favorites') ?? [];
    _favoriteIds
      ..clear()
      ..addAll(favoriteIdList.map((id) => int.parse(id)));
  }

  @override
  Future<void> saveSecondsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idList = _favoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('second_favorites', idList);
  }

  @override
  Future<void> loadDessertsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdList =
        prefs.getStringList('dessert_favorites') ?? [];
    _favoriteIds
      ..clear()
      ..addAll(favoriteIdList.map((id) => int.parse(id)));
  }

  @override
  Future<void> saveDessertsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idList = _favoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('dessert_favorites', idList);
  }
}
