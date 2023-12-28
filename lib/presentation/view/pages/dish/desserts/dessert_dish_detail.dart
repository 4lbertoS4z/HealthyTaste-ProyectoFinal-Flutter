import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/dessert_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';
import 'package:healthy_taste/presentation/widgets/youtube/video_player_screen.dart';

class DessertDishDetail extends StatefulWidget {
  final int id;
  const DessertDishDetail({super.key, required this.id});

  @override
  State<DessertDishDetail> createState() => _DessertDishDetailState();
}

class _DessertDishDetailState extends State<DessertDishDetail> {
  final DessertDishViewModel _viewModel = inject<DessertDishViewModel>();
  DishNetworkResponse? _dishDetails;
  @override
  void initState() {
    super.initState();
    _viewModel.fetchDessertDish(widget.id);
    _viewModel.getDessertDishDetailState.stream.listen((state) {
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
            _viewModel.fetchDessertDish(widget.id);
          });
          break;
      }
    });
    _viewModel.fetchDessertDish(widget.id);
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Ingredients:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Elaboration:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    const Text(
                      "Allergies:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CachedNetworkImage(
                      imageUrl: _dishDetails!.details.imgAllergies,
                      width: double.infinity,
                      height: 50,
                    )
                  ],
                ),
              ),
            const Text(
              "Video Detail:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
