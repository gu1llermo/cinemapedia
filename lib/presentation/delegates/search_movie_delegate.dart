import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  //
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingController = StreamController.broadcast();

  Timer? _debounceTimer;
  List<Movie> lastMovies = [];
  //bool _isBusy = false;

  SearchMovieDelegate({required this.searchMovies});

  void onQueryChanged(String query) {
    isLoadingController.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    //_isBusy = true;

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        searchMovies(query).then(
          (movies) {
            //_isBusy = false;
            isLoadingController.add(false);
            if (debouncedMovies.isClosed) return;
            lastMovies = movies;
            debouncedMovies.add(movies);
          },
        );
      },
    );
  }

  void clearStreams() {
    _debounceTimer?.cancel();
    debouncedMovies.close();
    isLoadingController.close();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder<List<Movie>>(
      stream: debouncedMovies.stream,
      initialData: lastMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovieSelected: () {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  Widget getActionIcon() {
    return StreamBuilder<bool>(
      stream: isLoadingController.stream,
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return SpinPerfect(
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)));
        }
        return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)));
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      getActionIcon()
      // SpinPerfect(
      //     infinite: true,
      //     child: IconButton(
      //         onPressed: () => query = '',
      //         icon: const Icon(Icons.refresh_rounded))),
      // FadeIn(
      //     animate: query.isNotEmpty,
      //     child: IconButton(
      //         onPressed: () => query = '', icon: const Icon(Icons.clear))),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null); // se coloco en null para no regresar nada
        },
        // cuando le den hacia atrás
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({required this.movie, required this.onMovieSelected});
  final Movie movie;
  final VoidCallback onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onMovieSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(children: [
          // Image
          SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) {
                      return FadeIn(child: child);
                    },
                  ))),
          const SizedBox(width: 10),
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textStyles.titleMedium,
                ),
                Text(
                  movie.overview,
                  maxLines: 3,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_half_rounded,
                      color: Colors.yellow.shade800,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      HumanFormats.number(movie.voteAverage, 1),
                      style: textStyles.bodyMedium!
                          .copyWith(color: Colors.yellow.shade900),
                    ),
                  ],
                )
              ],
            ),
          )
          // Description
        ]),
      ),
    );
  }
}
