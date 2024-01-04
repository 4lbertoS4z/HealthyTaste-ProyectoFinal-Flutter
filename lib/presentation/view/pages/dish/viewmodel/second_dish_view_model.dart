import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/base/base_view_model.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';

class SecondDishViewModel extends BaseViewModel {
  final DishRepository _secondDishrepository;
  final StreamController<ResourceState<List<DishNetworkResponse>>>
      getSecondDishState = StreamController();
  final StreamController<ResourceState<DishNetworkResponse>>
      getSecondDishDetailState = StreamController();
  SecondDishViewModel(
      {required DishRepository secondDishRepository,
      required DishLocalRepository localRepository})
      : _secondDishrepository = secondDishRepository;

  Future<void> fetchtSecondDishes() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      getSecondDishState
          .add(ResourceState.error(Exception("No internet Connect")));
    } else {
      _secondDishrepository.getSecondsList().then((value) {
        getSecondDishState.add(ResourceState.success(value));
      }).catchError((e) {
        debugPrint("Error en ViewModel: $e");
        getSecondDishState.add(ResourceState.error(e));
      });
    }
  }

  Future<void> fetchSecondDish(int id) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No hay conexión a Internet
      getSecondDishDetailState
          .add(ResourceState.error(Exception('No internet Connect')));
    } else {
      // Hay conexión a Internet, realiza la llamada a la API
      _secondDishrepository.getSecondDishById(id).then((value) {
        getSecondDishDetailState.add(ResourceState.success(value));
      }).catchError((e) {
        debugPrint("Error en ViewModel: $e");
        getSecondDishDetailState.add(ResourceState.error(e));
      });
    }
  }

  @override
  void dispose() {
    getSecondDishState.close();
    getSecondDishDetailState.close();
  }
}
