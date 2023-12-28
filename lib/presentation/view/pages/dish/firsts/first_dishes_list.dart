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
  List<DishNetworkResponse> filteredDishes = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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
              filteredDishes = firstDishes;
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

// Método para filtrar las recetas en función de la entrada de texto
  void filterDishes(String query) {
    setState(() {
      filteredDishes = firstDishes
          .where(
              (dish) => dish.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Dishess"),
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
                  _viewModel.fetchtFirstDishes();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredDishes.length,
                  itemBuilder: (context, index) {
                    return FirstDishRow(
                      firstDish: filteredDishes[index],
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
