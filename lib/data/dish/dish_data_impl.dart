import 'package:healthy_taste/data/dish/remote/dish_remote_impl.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_repository.dart';

class DishDataImpl extends DishRepository {
  final DishRemoteImpl _remoteImpl;

  DishDataImpl({required DishRemoteImpl remoteImpl}) : _remoteImpl = remoteImpl;

  @override
  Future<List<DishNetworkResponse>> getFirstList() {
    return _remoteImpl.getFirstList();
  }

  @override
  Future<List<DishNetworkResponse>> getDessertsList() {
    return _remoteImpl.getDessertsList();
  }

  @override
  Future<List<DishNetworkResponse>> getSecondsList() {
    return _remoteImpl.getSecondsList();
  }

  @override
  Future<DishNetworkResponse> getFirstDishById(int id) {
    return _remoteImpl.getFirstDishById(id);
  }

  @override
  Future<DishNetworkResponse> getDessertDishById(int id) {
    return _remoteImpl.getDessertDishById(id);
  }

  @override
  Future<DishNetworkResponse> getSecondDishById(int id) {
    return _remoteImpl.getSecondDishById(id);
  }
}
