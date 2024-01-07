import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DishLocalImp implements DishLocalRepository {
  final Set<int> _firstFavoriteIds = {};
  final Set<int> _secondsFavoriteIds = {};
  final Set<int> _dessertsFavoriteIds = {};

  @override
  Set<int> get firstFavoriteIds => _firstFavoriteIds;

  @override
  Set<int> get secondsFavoriteIds => _secondsFavoriteIds;

  @override
  Set<int> get dessertsFavoriteIds => _dessertsFavoriteIds;

  @override
  void toggleFirstFavorite(int id) {
    if (_firstFavoriteIds.contains(id)) {
      _firstFavoriteIds.remove(id);
    } else {
      _firstFavoriteIds.add(id);
    }
  }

  @override
  bool isFirstFavorite(int id) {
    return _firstFavoriteIds.contains(id);
  }

  @override
  void toggleSecondsFavorite(int id) {
    if (_secondsFavoriteIds.contains(id)) {
      _secondsFavoriteIds.remove(id);
    } else {
      _secondsFavoriteIds.add(id);
    }
  }

  @override
  bool isSecondsFavorite(int id) {
    return _secondsFavoriteIds.contains(id);
  }

  @override
  void toggleDessertsFavorite(int id) {
    if (_dessertsFavoriteIds.contains(id)) {
      _dessertsFavoriteIds.remove(id);
    } else {
      _dessertsFavoriteIds.add(id);
    }
  }

  @override
  bool isDessertsFavorite(int id) {
    return _dessertsFavoriteIds.contains(id);
  }

  @override
  Future<void> loadFirstDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdList = prefs.getStringList('first_favorites') ?? [];
    _firstFavoriteIds
      ..clear()
      ..addAll(favoriteIdList.map((id) => int.parse(id)));
  }

  @override
  Future<void> saveFirstDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idList = _firstFavoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('first_favorites', idList);
  }

  @override
  Future<void> loadSecondsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdList = prefs.getStringList('second_favorites') ?? [];
    _secondsFavoriteIds
      ..clear()
      ..addAll(favoriteIdList.map((id) => int.parse(id)));
  }

  @override
  Future<void> saveSecondsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idList =
        _secondsFavoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('second_favorites', idList);
  }

  @override
  Future<void> loadDessertsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdList =
        prefs.getStringList('dessert_favorites') ?? [];
    _dessertsFavoriteIds
      ..clear()
      ..addAll(favoriteIdList.map((id) => int.parse(id)));
  }

  @override
  Future<void> saveDessertsDishFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idList =
        _dessertsFavoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('dessert_favorites', idList);
  }
}
