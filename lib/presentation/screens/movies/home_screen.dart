import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.childView});

  // static const String path = '/';
  static const String name = 'home-screen';
  final Widget childView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: childView,
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
