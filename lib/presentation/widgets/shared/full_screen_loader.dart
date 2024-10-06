import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  static const List<String> _messages = [
    'Cargando películas',
    'Comprando palomitas de maíz',
    'Cargando populares',
    'Llamando a fulanito',
    'Cualquier cosa...',
    'Se está tardando más de lo normal',
  ];

  Stream<String> getLoadingMessages() async* {
    yield* Stream.periodic(
      const Duration(milliseconds: 1200),
      (step) => _messages[step],
    ).take(_messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            return Text(snapshot.data!);
          },
        ),
      ],
    );
  }
}
