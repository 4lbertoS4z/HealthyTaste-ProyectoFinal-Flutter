// ignore_for_file: constant_identifier_names

import 'package:go_router/go_router.dart';
import 'package:healthy_taste/presentation/view/pages/home_page.dart';
import 'package:healthy_taste/presentation/view/splash/splash_page.dart';

class NavigationRoutes {
  // Routes
  static const String INITIAL_ROUTE = "/";
  static const String HOME_CATEGORIES_ROUTE = "/home-categories";
  /* static const String JOKE_DETAIL_ROUTE =
      "$HOME_CATEGORIES_ROUTE/$_JOKE_DETAIL_PATH"; */

  // Paths
//  static const String _JOKE_DETAIL_PATH = "joke-detail";
}

final GoRouter router = GoRouter(
  initialLocation: NavigationRoutes.INITIAL_ROUTE,
  routes: [
    GoRoute(
      path: NavigationRoutes.INITIAL_ROUTE,
      builder: (context, state) => const SplashPage(),
    ),
    //,
    GoRoute(
        path: NavigationRoutes.HOME_CATEGORIES_ROUTE,
        builder: (context, state) => const HomePage(),
        routes: const [
          /*   GoRoute(
            path: NavigationRoutes._JOKE_DETAIL_PATH,
            builder: (context, state) =>
                JokeDetailPage(category: state.extra as String),
          ) */
        ])
  ],
);
