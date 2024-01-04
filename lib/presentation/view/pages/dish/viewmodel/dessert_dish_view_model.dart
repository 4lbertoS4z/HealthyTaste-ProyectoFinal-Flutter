import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/base/base_view_model.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';

class DessertDishViewModel extends BaseViewModel {
  final DishRepository _dessertDishrepository;
  final StreamController<ResourceState<List<DishNetworkResponse>>>
      getDessertDishState = StreamController();
  final StreamController<ResourceState<DishNetworkResponse>>
      getDessertDishDetailState = StreamController();
  DessertDishViewModel(
      {required DishRepository dessertDishRepository,
      required DishLocalRepository localRepository})
      : _dessertDishrepository = dessertDishRepository;

  Future<void> fetchtDessertDishes() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No hay conexión a Internet
      getDessertDishState
          .add(ResourceState.error(Exception('No Internet Connect')));
    } else {
      // Hay conexión a Internet, realiza la llamada a la API
      _dessertDishrepository.getDessertsList().then((value) {
        getDessertDishState.add(ResourceState.success(value));
      }).catchError((e) {
        debugPrint("Error en ViewModel: $e");
        getDessertDishState.add(ResourceState.error(e));
      });
    }
  }

  Future<void> fetchDessertDish(int id) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No hay conexión a Internet
      getDessertDishDetailState
          .add(ResourceState.error(Exception('No internet Connect')));
    } else {
      // Hay conexión a Internet, realiza la llamada a la API
      _dessertDishrepository.getDessertDishById(id).then((value) {
        getDessertDishDetailState.add(ResourceState.success(value));
      }).catchError((e) {
        debugPrint("Error en ViewModel: $e");
        getDessertDishDetailState.add(ResourceState.error(e));
      });
    }
  }

  @override
  void dispose() {
    getDessertDishState.close();
    getDessertDishDetailState.close();
  }
}
