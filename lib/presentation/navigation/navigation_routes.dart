// ignore_for_file: constant_identifier_names

import 'package:go_router/go_router.dart';
import 'package:healthy_taste/presentation/view/pages/dish/desserts/dessert_dish_detail.dart';
import 'package:healthy_taste/presentation/view/pages/dish/desserts/dessert_dishes_list.dart';
import 'package:healthy_taste/presentation/view/pages/dish/firsts/first_dish_detail.dart';
import 'package:healthy_taste/presentation/view/pages/dish/firsts/first_dishes_list.dart';
import 'package:healthy_taste/presentation/view/pages/dish/seconds/second_dish_detail.dart';
import 'package:healthy_taste/presentation/view/pages/dish/seconds/second_dishes_list.dart';
import 'package:healthy_taste/presentation/view/pages/home_page.dart';
import 'package:healthy_taste/presentation/view/pages/kcal_webview.dart';
import 'package:healthy_taste/presentation/view/splash/splash_page.dart';

class NavigationRoutes {
  // Routes
  static const String INITIAL_ROUTE = "/";
  static const FIRST_DISH_ROUTE = "/first";
  static const SECOND_DISH_ROUTE = "/second";
  static const THIRD_DISH_ROUTE = "/third";
  static const KCAL_CALCULATOR_ROUTE = "/kcal";
  static const FIRST_DETAIL_PAGE = "$FIRST_DISH_ROUTE/$_FIRST_PATH";
  static const SECOND_DETAIL_PAGE = "$SECOND_DISH_ROUTE/$_SECOND_PATH";
  static const DESSERT_DETAIL_PAGE = "$THIRD_DISH_ROUTE/$_DESSERT_PATH";

  static const _FIRST_PATH = "first-detail";
  static const _SECOND_PATH = "second-detail";
  static const _DESSERT_PATH = "dessert-detail";
}

final GoRouter router =
    GoRouter(initialLocation: NavigationRoutes.INITIAL_ROUTE, routes: [
  GoRoute(
    path: NavigationRoutes.INITIAL_ROUTE,
    builder: (context, state) => const SplashPage(),
  ),
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomePage(
            navigationShell: navigationShell,
          ),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.FIRST_DISH_ROUTE,
            builder: (context, state) => const FirstDishesList(),
            routes: [
              GoRoute(
                path: NavigationRoutes._FIRST_PATH,
                builder: (context, state) {
                  final id = int.parse(state.uri.queryParameters['id']!);

                  return FirstDishDetail(id: id);
                },
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.SECOND_DISH_ROUTE,
            builder: (context, state) => const SecondDishesList(),
            routes: [
              GoRoute(
                path: NavigationRoutes._SECOND_PATH,
                builder: (context, state) {
                  final id = int.parse(state.uri.queryParameters['id']!);

                  return SecondDishDetail(id: id);
                },
              ),
            ],
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.THIRD_DISH_ROUTE,
            builder: (context, state) => const DessertDishesList(),
            routes: [
              GoRoute(
                path: NavigationRoutes._DESSERT_PATH,
                builder: (context, state) {
                  final id = int.parse(state.uri.queryParameters['id']!);

                  return DessertDishDetail(id: id);
                },
              ),
            ],
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.KCAL_CALCULATOR_ROUTE,
            builder: (context, state) => const KcalWebView(),
          )
        ])
      ])
]);
