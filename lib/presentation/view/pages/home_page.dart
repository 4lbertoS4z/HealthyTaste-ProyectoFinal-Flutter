import 'package:flutter/material.dart';
import 'package:healthy_taste/presentation/view/pages/dish/desserts/dessert_dishes_list.dart';
import 'package:healthy_taste/presentation/view/pages/dish/firsts/first_dishes_list.dart';
import 'package:healthy_taste/presentation/view/pages/dish/seconds/second_dishes_list.dart';
import 'package:healthy_taste/presentation/view/pages/kcal_webview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Inicializa el TabController con 4 tabs
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    // Asegúrate de disponer el TabController para evitar fugas de memoria
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Taste'),
        bottom: TabBar(
          controller: _tabController,
          // Define las pestañas aquí
          tabs: const [
            Tab(text: 'Entrantes'),
            Tab(text: 'Segundos'),
            Tab(text: 'Postres'),
            Tab(text: 'Kcal'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        // Contenido para cada tab
        children: const [
          FirstDishesList(),
          SecondDishesList(),
          DessertDishesList(),
          KcalWebView(),
        ],
      ),
    );
  }
}
