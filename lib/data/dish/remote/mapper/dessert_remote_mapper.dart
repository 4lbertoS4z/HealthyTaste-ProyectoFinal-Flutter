import 'package:healthy_taste/data/dish/remote/model/dish_network_response.dart';
import 'package:healthy_taste/model/first.dart';

class DessertRemoteMapper {
  static Dessert fromRemote(DishNetworkResponse responseModel) {
    return Dessert(
      id: responseModel.id,
      name: responseModel.name,
      image: responseModel.image,
      details: Details(
        elaboration: responseModel.details.elaboration,
        imgAllergies: responseModel.details.imgAllergies,
        ingredients: responseModel.details.ingredients,
        urlVideo: responseModel.details.urlVideo,
      ),
    );
  }
}
