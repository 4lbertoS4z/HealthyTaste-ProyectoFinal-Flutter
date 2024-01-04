import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/generated/l10n.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/firsts/first_dish_row.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/first_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';

class FirstDishesList extends StatefulWidget {
  const FirstDishesList({Key? key}) : super(key: key);

  @override
  State<FirstDishesList> createState() => _FirstDishesListState();
}

class _FirstDishesListState extends State<FirstDishesList> {
  final FirstDishViewModel _viewModel = inject<FirstDishViewModel>();
  List<DishNetworkResponse> firstDishes = [];
  List<DishNetworkResponse> filteredDishes = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late DishLocalRepository _favoritesService;

  @override
  void initState() {
    super.initState();
    _favoritesService = inject<DishLocalRepository>();
    _favoritesService.loadFirstDishFavorites().then((_) {
      setState(() {
        _sortDishes();
      });
    });

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
              _sortDishes();
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

  void _sortDishes() {
    filteredDishes.sort((a, b) {
      final aIsFavorite = _favoritesService.isFavorite(a.id);
      final bIsFavorite = _favoritesService.isFavorite(b.id);
      if (aIsFavorite == bIsFavorite) return 0;
      return aIsFavorite ? -1 : 1;
    });
  }

  void filterDishes(String query) {
    setState(() {
      filteredDishes = firstDishes
          .where(
              (dish) => dish.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _sortDishes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).firstDishes),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterDishes,
                decoration: InputDecoration(
                  labelText: S.of(context).search,
                  border: const OutlineInputBorder(),
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
                  padding: const EdgeInsets.only(bottom: 80.0),
                  itemBuilder: (context, index) {
                    return FirstDishRow(
                      firstDish: filteredDishes[index],
                      favoritesService: _favoritesService,
                      onFavoriteChanged: () {
                        setState(() {
                          _sortDishes();
                        });
                      },
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
