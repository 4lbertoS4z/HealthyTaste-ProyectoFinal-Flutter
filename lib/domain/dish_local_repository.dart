abstract class DishLocalRepository {
  Set<int> get favoriteIds;
  void toggleFavorite(int id);
  bool isFavorite(int id);
  Future<void> loadFirstDishFavorites();
  Future<void> saveFirstDishFavorites();
  Future<void> loadSecondsDishFavorites();
  Future<void> saveSecondsDishFavorites();
  Future<void> loadDessertsDishFavorites();
  Future<void> saveDessertsDishFavorites();
}
