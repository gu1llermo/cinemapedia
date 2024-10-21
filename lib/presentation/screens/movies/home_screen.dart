import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.pageIndex});
  final int pageIndex;
  // static const String path = '/';
  static const String name = 'home-screen';

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    final pageIndexAux = pageIndex < 0
        ? 0
        : (pageIndex >= viewRoutes.length)
            ? (viewRoutes.length - 1)
            : pageIndex;
    return Scaffold(
      body: IndexedStack(
        index: pageIndexAux,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: pageIndexAux,
      ),
    );
  }
}
