import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/generated/l10n.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/second_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';
import 'package:healthy_taste/presentation/widgets/nutrients/nutrition_chart.dart';
import 'package:healthy_taste/presentation/widgets/youtube/video_player_screen.dart';

class SecondDishDetail extends StatefulWidget {
  final int id;
  const SecondDishDetail({super.key, required this.id});

  @override
  State<SecondDishDetail> createState() => _SecondDishDetailState();
}

class _SecondDishDetailState extends State<SecondDishDetail> {
  final SecondDishViewModel _viewModel = inject<SecondDishViewModel>();
  DishNetworkResponse? _dishDetails;

  @override
  void initState() {
    super.initState();
    _viewModel.fetchSecondDish(widget.id);
    _viewModel.getSecondDishDetailState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          if (state.data != null) {
            setState(() {
              _dishDetails = state.data;
            });
            LoadingView.hide();
          }
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _viewModel.fetchSecondDish(widget.id);
          });
          break;
      }
    });
    _viewModel.fetchSecondDish(widget.id);
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
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).ingredients,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _dishDetails!.details.ingredients.join('\n'),
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).elaboration,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _dishDetails!.details.elaboration,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
            if (_dishDetails!.details.imgAllergies.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).nutrients,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            if (_dishDetails != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: NutritionChart(
                    calories: _dishDetails!.details.calories,
                    proteins: _dishDetails!.details.proteins,
                    fats: _dishDetails!.details.fats,
                    carbohydrates: _dishDetails!.details.carbohydrates,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).videoDetail,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            if (_dishDetails!.details.urlVideo.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    VideoPlayerScreen(videoId: _dishDetails!.details.urlVideo),
              ),
          ],
        ),
      );
    }
  }
}
