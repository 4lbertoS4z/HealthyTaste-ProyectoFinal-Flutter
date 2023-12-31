import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_taste/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (value) {
          widget.navigationShell.goBranch(value,
              initialLocation: value == widget.navigationShell.currentIndex);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: S.of(context).first,
          ),
          NavigationDestination(
            icon: const Icon(Icons.fastfood_outlined),
            selectedIcon: const Icon(Icons.fastfood),
            label: S.of(context).seconds,
          ),
          NavigationDestination(
            icon: const Icon(Icons.cake_outlined),
            selectedIcon: const Icon(Icons.cake),
            label: S.of(context).desserts,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calculate_outlined),
            selectedIcon: const Icon(Icons.calculate),
            label: S.of(context).kcal,
          ),
        ],
      ),
    );
  }
}
