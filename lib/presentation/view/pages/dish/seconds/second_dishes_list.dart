import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/seconds/second_dish_row.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/second_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';

class SecondDishesList extends StatefulWidget {
  const SecondDishesList({Key? key}) : super(key: key);

  @override
  State<SecondDishesList> createState() => _SecondDishesListState();
}

class _SecondDishesListState extends State<SecondDishesList> {
  final SecondDishViewModel _viewModel = inject<SecondDishViewModel>();
  List<DishNetworkResponse> secondDishes = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
              filterDishes(searchController.text);
            });
            LoadingView.hide();
          }
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _viewModel.fetchtSecondDishes();
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

  List<DishNetworkResponse> filteredDishes = [];

  void filterDishes(String query) {
    final keywords = query.toLowerCase().split(' ');
    setState(() {
      filteredDishes = secondDishes.where((dish) {
        final dishNameLower = dish.name.toLowerCase();
        return keywords.any((keyword) => dishNameLower.contains(keyword));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Dishes"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterDishes(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _viewModel.fetchtSecondDishes();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredDishes.length,
                  itemBuilder: (context, index) {
                    return SecondDishRow(
                      secondDish: filteredDishes[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        mini: true,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
