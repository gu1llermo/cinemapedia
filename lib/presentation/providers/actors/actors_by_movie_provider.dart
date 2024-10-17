import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final repository = ref.read(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: repository.getActorsByMovie);
});

/*
{
  '11111': List<Actor>,
  '22222': List<Actor>,
  '33333': List<Actor>,
}
*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback _getActors;

  ActorsByMovieNotifier({
    required Future<List<Actor>> Function(String) getActors,
  })  : _getActors = getActors,
        super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return; // si existe entonces no cargas nada

    final actors = await _getActors(movieId);

    state = {...state, movieId: actors};
  }
}
