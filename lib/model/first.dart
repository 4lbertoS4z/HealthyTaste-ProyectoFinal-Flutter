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

  Details({
    required this.elaboration,
    required this.imgAllergies,
    required this.ingredients,
    required this.urlVideo,
  });
}
