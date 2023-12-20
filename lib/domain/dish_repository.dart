import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';

abstract class DishRepository {
  Future<List<DishNetworkResponse>> getFirstList();
  Future<List<DishNetworkResponse>> getSecondsList();
  Future<List<DishNetworkResponse>> getDessertsList();
  Future<DishNetworkResponse> getFirstDishById(int id);
  Future<DishNetworkResponse> getSecondDishById(int id);
  Future<DishNetworkResponse> getDessertDishById(int id);
}
