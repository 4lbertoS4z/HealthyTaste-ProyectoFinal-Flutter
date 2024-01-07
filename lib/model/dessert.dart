import 'package:healthy_taste/model/details.dart';

class Dessert {
  Details details;
  int id;
  int numPersons;
  String image;
  String name;

  Dessert({
    required this.details,
    required this.id,
    required this.numPersons,
    required this.image,
    required this.name,
  });
}
