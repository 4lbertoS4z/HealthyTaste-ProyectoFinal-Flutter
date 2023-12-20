import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "First",
          ),
          NavigationDestination(
            icon: Icon(Icons.fastfood_outlined),
            selectedIcon: Icon(Icons.fastfood),
            label: "Seconds",
          ),
          NavigationDestination(
            icon: Icon(Icons.cake_outlined),
            selectedIcon: Icon(Icons.cake),
            label: "Desserts",
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: "Kcal",
          ),
        ],
      ),
    );
  }
}
