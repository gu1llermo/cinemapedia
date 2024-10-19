import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
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
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ],
    )

    // Rutas padre/hijo
    // GoRoute(
    //     path: '/',
    //     name: HomeScreen.name,
    //     builder: (context, state) => const HomeScreen(
    //           childView: FavoritesView(),
    //         ),
    //     routes: [
    //       // estas son rutas hijas, antecedidas por el /
    //       // en éste caso
    //       GoRoute(
    //         path: 'movie/:id',
    //         name: MovieScreen.name,
    //         builder: (context, state) {
    //           final moviId = state.pathParameters['id'] ?? 'no-id';
    //           return MovieScreen(
    //             movieId: moviId,
    //           );
    //         },
    //       ),
    //     ]),
  ],
);
