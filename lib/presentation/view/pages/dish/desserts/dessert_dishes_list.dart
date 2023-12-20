import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/desserts/dessert_dish_row.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/dessert_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';

class DessertDishesList extends StatefulWidget {
  const DessertDishesList({super.key});

  @override
  State<DessertDishesList> createState() => _DessertDishesListState();
}

class _DessertDishesListState extends State<DessertDishesList> {
  final DessertDishViewModel _viewModel = inject<DessertDishViewModel>();
  List<DishNetworkResponse> dessertDishes = [];

  @override
  void initState() {
    super.initState();
    _viewModel.fetchtDessertDishes();
    _viewModel.getDessertDishState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          if (state.data != null) {
            setState(() {
              dessertDishes = state.data!;
            });
            LoadingView.hide();
          }
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _viewModel.fetchtDessertDishes();
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dessert Dishes"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _viewModel.fetchtDessertDishes();
          },
          child: ListView.builder(
            itemCount: dessertDishes.length,
            itemBuilder: (context, index) {
              return DessertDishRow(
                dessertDish: dessertDishes[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
