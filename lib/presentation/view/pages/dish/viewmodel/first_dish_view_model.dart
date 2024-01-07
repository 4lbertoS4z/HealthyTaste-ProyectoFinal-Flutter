import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/base/base_view_model.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';

class FirstDishViewModel extends BaseViewModel {
  final DishRepository _firstDishRepository;

  final StreamController<ResourceState<List<DishNetworkResponse>>>
      getFirstDishesState = StreamController();

  final StreamController<ResourceState<DishNetworkResponse>>
      getFirstDishDetailState = StreamController();

  FirstDishViewModel(
      {required DishRepository firstDishRepository,
      required DishLocalRepository localRepository})
      : _firstDishRepository = firstDishRepository;

  Future<void> fetchtFirstDishes() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      getFirstDishesState
          .add(ResourceState.error(Exception('No Internet Connect')));
    } else {
      _firstDishRepository.getFirstList().then((value) {
        getFirstDishesState.add(ResourceState.success(value));
      }).catchError((e) {
        debugPrint("Error en ViewModel: $e");
        getFirstDishesState.add(ResourceState.error(e));
      });
    }
  }

  Future<void> fetchFirstDish(int id) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      getFirstDishDetailState
          .add(ResourceState.error(Exception('No internet Connect')));
    } else {
      _firstDishRepository.getFirstDishById(id).then((value) {
        getFirstDishDetailState.add(ResourceState.success(value));
      }).catchError((e) {
        debugPrint("Error en ViewModel: $e");
        getFirstDishDetailState.add(ResourceState.error(e));
      });
    }
  }

  @override
  void dispose() {
    getFirstDishesState.close();
    getFirstDishDetailState.close();
  }
}
