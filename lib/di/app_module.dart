import 'package:get_it/get_it.dart';
import 'package:healthy_taste/data/dish/dish_data_impl.dart';
import 'package:healthy_taste/data/dish/local/dish_local_imp.dart';
import 'package:healthy_taste/data/dish/remote/dish_remote_impl.dart';
import 'package:healthy_taste/data/remote/network_client.dart';
import 'package:healthy_taste/domain/dish_local_repository.dart';
import 'package:healthy_taste/domain/dish_repository.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/dessert_dish_view_model.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/first_dish_view_model.dart';
import 'package:healthy_taste/presentation/view/pages/dish/viewmodel/second_dish_view_model.dart';

final inject = GetIt.instance;

class AppModules {
  void setup() {
    _setupMainModule();
    _setupFirstModule();
  }

  void _setupMainModule() {
    inject.registerSingleton(NetworkClient());
    inject.registerSingleton<DishLocalRepository>(DishLocalImp());
  }

  void _setupFirstModule() {
    inject.registerFactory(() => DishRemoteImpl(networkClient: inject.get()));
    inject.registerFactory<DishRepository>(
        () => DishDataImpl(remoteImpl: inject.get()));

    inject.registerFactory(() => FirstDishViewModel(
        firstDishRepository: inject.get(),
        localRepository:
            inject.get<DishLocalRepository>())); // Añade la dependencia

    inject.registerFactory(() => SecondDishViewModel(
        secondDishRepository: inject.get(),
        localRepository:
            inject.get<DishLocalRepository>())); // Añade la dependencia

    inject.registerFactory(() => DessertDishViewModel(
        dessertDishRepository: inject.get(),
        localRepository:
            inject.get<DishLocalRepository>())); // Añade la dependencia
  }
}
