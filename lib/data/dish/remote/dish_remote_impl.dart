import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/data/remote/error/remote_error_mapper.dart';
import 'package:healthy_taste/data/remote/network_client.dart';
import 'package:healthy_taste/data/remote/network_constants.dart';

class DishRemoteImpl {
  final NetworkClient _networkClient;

  DishRemoteImpl({required NetworkClient networkClient})
      : _networkClient = networkClient;

  Future<List<DishNetworkResponse>> getFirstList() async {
    try {
      final response =
          await _networkClient.dio.get(NetworkConstants.FIRST_PATH);

      return (response.data as List)
          .map((e) => DishNetworkResponse.fromMap(e))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<List<DishNetworkResponse>> getSecondsList() async {
    try {
      final response =
          await _networkClient.dio.get(NetworkConstants.SECONDS_PATH);

      return (response.data as List)
          .map((e) => DishNetworkResponse.fromMap(e))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<List<DishNetworkResponse>> getDessertsList() async {
    try {
      final response =
          await _networkClient.dio.get(NetworkConstants.DESSERTS_PATH);

      return (response.data as List)
          .map((e) => DishNetworkResponse.fromMap(e))
          .toList();
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
