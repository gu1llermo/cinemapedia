import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final movieRepository = ref.watch(movieRepositoryProvider);

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              Icons.movie_outlined,
              color: colors.primary,
            ),
            const SizedBox(width: 5),
            Text(
              'Cinemapedia',
              style: titleStyle,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showSearch(
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovies: movieRepository.searchMovie))
                      .then((movie) {
                    if (movie == null) return;
                    if (context.mounted) {
                      context.push('/movie/${movie.id}');
                    }
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
