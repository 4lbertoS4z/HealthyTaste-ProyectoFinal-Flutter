import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/firsts/first_dish_row.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/first_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';

class FirstDishesList extends StatefulWidget {
  const FirstDishesList({super.key});

  @override
  State<FirstDishesList> createState() => _FirstDishesListState();
}

class _FirstDishesListState extends State<FirstDishesList> {
  final FirstDishViewModel _viewModel = inject<FirstDishViewModel>();
  List<DishNetworkResponse> firstDishes = [];

  @override
  void initState() {
    super.initState();
    _viewModel.fetchtFirstDishes();
    _viewModel.getFirstDishesState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          if (state.data != null) {
            setState(() {
              firstDishes = state.data!;
            });
            LoadingView.hide();
          }
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _viewModel.fetchtFirstDishes();
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
        title: const Text("First Dishes"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _viewModel.fetchtFirstDishes();
          },
          child: ListView.builder(
            itemCount: firstDishes.length,
            itemBuilder: (context, index) {
              return FirstDishRow(
                firstDish: firstDishes[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
