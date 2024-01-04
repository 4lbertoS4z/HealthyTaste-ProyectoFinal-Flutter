class DishNetworkResponse {
  DetailsResponse details;
  int id;
  String image;
  String name;

  DishNetworkResponse({
    required this.details,
    required this.id,
    required this.image,
    required this.name,
  });

  factory DishNetworkResponse.fromMap(Map<String, dynamic> json) =>
      DishNetworkResponse(
        details: DetailsResponse.fromMap(json["details"]),
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "details": details.toMap(),
        "id": id,
        "image": image,
        "name": name,
      };
}

class DetailsResponse {
  String elaboration;
  String imgAllergies;
  List<String> ingredients;
  String urlVideo;
  double calories;
  double proteins;
  double fats;
  double carbohydrates;

  DetailsResponse({
    required this.elaboration,
    required this.imgAllergies,
    required this.ingredients,
    required this.urlVideo,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
  });

  factory DetailsResponse.fromMap(Map<String, dynamic> json) => DetailsResponse(
        elaboration: json["elaboration"] ?? '',
        imgAllergies: json["img_allergies"] ?? '',
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        urlVideo: json["url_video"] ?? '',
        calories: json["Calorías"]?.toDouble() ?? 0.0,
        proteins: json["Proteínas"]?.toDouble() ?? 0.0,
        fats: json["Grasas"]?.toDouble() ?? 0.0,
        carbohydrates: json["Carbohidratos"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toMap() => {
        "elaboration": elaboration,
        "img_allergies": imgAllergies,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "url_video": urlVideo,
        "Calorías": calories,
        "Proteínas": proteins,
        "Grasas": fats,
        "Carbohidratos": carbohydrates,
      };
}
