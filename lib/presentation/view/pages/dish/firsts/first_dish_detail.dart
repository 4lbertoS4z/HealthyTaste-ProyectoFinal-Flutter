import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/generated/l10n.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/first_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';
import 'package:healthy_taste/presentation/widgets/nutrients/nutrition_chart.dart';
import 'package:healthy_taste/presentation/widgets/youtube/video_player_screen.dart';

class FirstDishDetail extends StatefulWidget {
  final int id;

  const FirstDishDetail({super.key, required this.id});

  @override
  State<FirstDishDetail> createState() => _FirstDishDetailState();
}

class _FirstDishDetailState extends State<FirstDishDetail> {
  final FirstDishViewModel _viewModel = inject<FirstDishViewModel>();
  DishNetworkResponse? _dishDetails;

  @override
  void initState() {
    super.initState();
    _viewModel.fetchFirstDish(widget.id);
    _viewModel.getFirstDishDetailState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          if (state.data != null) {
            setState(() {
              _dishDetails = state.data;
            });
            debugPrint('First dish detail loaded: ${_dishDetails.toString()}');
            LoadingView.hide();
          }
          break;
        case Status.ERROR:
          debugPrint('Error loading first dish detail: ${state.exception}');
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _viewModel.fetchFirstDish(widget.id);
          });
          break;
      }
    });
    _viewModel.fetchFirstDish(widget.id);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building FirstDishDetail Widget');
    return Scaffold(
      appBar: AppBar(
        title: Text(_dishDetails?.name ?? 'Loading...'),
      ),
      body: _buildDishDetails(),
      backgroundColor: const Color(0xFFF5DEB3),
    );
  }

  Widget _buildDishDetails() {
    if (_dishDetails == null) {
      return const CircularProgressIndicator();
    } else {
      debugPrint('Showing details for dish: ${_dishDetails!.name}');
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: _dishDetails!.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).ingredients,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                _dishDetails!.details.ingredients.join('\n'),
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).elaboration,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                _dishDetails!.details.elaboration,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
            if (_dishDetails!.details.imgAllergies.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).allergies,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CachedNetworkImage(
                      imageUrl: _dishDetails!.details.imgAllergies,
                      width: double.infinity,
                      height: 50,
                    )
                  ],
                ),
              ),
            Text(
              S.of(context).nutrients,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (_dishDetails != null)
              SizedBox(
                height: 200, // Define un alto fijo
                width: double.infinity,
                child: NutritionChart(
                  calories: _dishDetails!.details.calories,
                  proteins: _dishDetails!.details.proteins,
                  fats: _dishDetails!.details.fats,
                  carbohydrates: _dishDetails!.details.carbohydrates,
                ),
              ),
            Text(
              S.of(context).videoDetail,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (_dishDetails!.details.urlVideo.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child:
                    VideoPlayerScreen(videoId: _dishDetails!.details.urlVideo),
              ),
          ],
        ),
      );
    }
  }
}
