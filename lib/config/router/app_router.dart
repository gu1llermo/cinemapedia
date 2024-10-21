import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

          return HomeScreen(
            pageIndex: pageIndex,
          );
        },
        routes: [
          // estas son rutas hijas, antecedidas por el /
          // en éste caso
          GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final moviId = state.pathParameters['id'] ?? 'no-id';
              return MovieScreen(
                movieId: moviId,
              );
            },
          ),
        ]),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ],
);
