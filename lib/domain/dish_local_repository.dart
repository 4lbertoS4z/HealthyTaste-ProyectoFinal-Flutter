abstract class DishLocalRepository {
  Set<int> get firstFavoriteIds;
  Set<int> get secondsFavoriteIds;
  Set<int> get dessertsFavoriteIds;
  void toggleFirstFavorite(int id);
  bool isFirstFavorite(int id);
  void toggleSecondsFavorite(int id);
  bool isSecondsFavorite(int id);
  void toggleDessertsFavorite(int id);
  bool isDessertsFavorite(int id);
  Future<void> loadFirstDishFavorites();
  Future<void> saveFirstDishFavorites();
  Future<void> loadSecondsDishFavorites();
  Future<void> saveSecondsDishFavorites();
  Future<void> loadDessertsDishFavorites();
  Future<void> saveDessertsDishFavorites();
}
