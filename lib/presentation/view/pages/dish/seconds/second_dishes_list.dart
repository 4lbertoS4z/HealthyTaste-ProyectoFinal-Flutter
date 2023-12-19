import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/seconds/second_dish_row.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/second_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';

class SecondDishesList extends StatefulWidget {
  const SecondDishesList({super.key});

  @override
  State<SecondDishesList> createState() => _SecondDishesListState();
}

class _SecondDishesListState extends State<SecondDishesList> {
  final SecondDishViewModel _viewModel = inject<SecondDishViewModel>();
  List<DishNetworkResponse> secondDishes = [];

  @override
  void initState() {
    super.initState();
    _viewModel.fetchtSecondDishes();
    _viewModel.getSecondDishState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          if (state.data != null) {
            setState(() {
              secondDishes = state.data!;
            });
            LoadingView.hide();
          }
          break;
        case Status.ERROR:
          LoadingView.hide();
          _showError(state.error!);
          break;
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  _showError(Error error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Dishes"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _viewModel.fetchtSecondDishes();
          },
          child: ListView.builder(
            itemCount: secondDishes.length,
            itemBuilder: (context, index) {
              return SecondDishRow(
                secondDish: secondDishes[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
