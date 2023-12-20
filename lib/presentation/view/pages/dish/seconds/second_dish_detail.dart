import 'package:flutter/material.dart';
import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/presentation/model/resource_state.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/second_dish_view_model.dart';
import 'package:healthy_taste/presentation/widgets/error/error_view.dart';
import 'package:healthy_taste/presentation/widgets/loading/loading_view.dart';

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
    );
  }

  Widget _buildDishDetails() {
    if (_dishDetails == null) {
      return const CircularProgressIndicator();
    } else {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(_dishDetails!.image),
            Text(_dishDetails!.details.elaboration),
            // Aquí puedes agregar más widgets para mostrar otros detalles
          ],
        ),
      );
    }
  }
}
