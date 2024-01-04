class First {
  Details details;
  int id;
  String image;
  String name;

  First({
    required this.details,
    required this.id,
    required this.image,
    required this.name,
  });
}

class Second {
  Details details;
  int id;
  String image;
  String name;

  Second({
    required this.details,
    required this.id,
    required this.image,
    required this.name,
  });
}

class Dessert {
  Details details;
  int id;
  String image;
  String name;

  Dessert({
    required this.details,
    required this.id,
    required this.image,
    required this.name,
  });
}

class Details {
  String elaboration;
  String imgAllergies;
  List<String> ingredients;
  String urlVideo;
  double calories;
  double proteins;
  double fats;
  double carbohydrates;

  Details({
    required this.elaboration,
    required this.imgAllergies,
    required this.ingredients,
    required this.urlVideo,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
  });
}
