import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/generated/l10n.dart';
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
  List<DishNetworkResponse> filteredDishes = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late DishLocalRepository _favoritesService;

  @override
  void initState() {
    super.initState();
    _favoritesService = inject<DishLocalRepository>();
    _favoritesService.loadSecondsDishFavorites().then((_) {
      setState(() {
        _sortDishes();
      });
    });
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
              filteredDishes = secondDishes;
              _sortDishes();
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
      filteredDishes = secondDishes
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
        title: Text(S.of(context).secondDishes),
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
                decoration: InputDecoration(
                  labelText: S.of(context).search,
                  border: const OutlineInputBorder(),
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
                  padding: const EdgeInsets.only(bottom: 80.0),
                  itemBuilder: (context, index) {
                    return SecondDishRow(
                      secondDish: filteredDishes[index],
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
