import 'dart:async';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SembastDatasource extends LocalStorageDatasource {
  final String nameStore = 'movie_sembast_store';
  final String nameDb = 'movies_favorities.db';
  Database? _database;
  late StoreRef<int, Map<String, Object?>> _store;

  SembastDatasource() {
    _store = intMapStoreFactory.store(nameStore);
  }

  /// When set to true, the database will be opened from a volatile a space in
  /// memory instead. Great for testing purposes.
  bool openDatabaseFromMemory = false;

  /// The local database.
  Future<Database> get database async => _database ??= await _createDatabase();

  Future<Database> _createDatabase() async {
    final fileName = nameDb;

    if (openDatabaseFromMemory) {
      return databaseFactoryMemory.openDatabase(fileName);
    }

    if (kIsWeb) {
      return databaseFactoryWeb.openDatabase(fileName);
    }

    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final path = join(dir.path, fileName);
    return databaseFactoryIo.openDatabase(path);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    // pregunta si ésta película existe en la base de datos, si existe es porque es favorita
    final db = await database;
    // final mapRecord = await _store.record(movieId).get(db);
    // // supongo que si no lo consigue regresa null
    // return mapRecord != null; // si es distinto de null es porque existe

    final finder = Finder(
      filter:
          Filter.equals('id', movieId), //  lo quise hacer así, que es diferente
    );
    // Find the first record matching the finder
    final record = await _store.findFirst(db, finder: finder);
    return record != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final db = await database;
    final snapshots = await _store.query().getSnapshots(db);

    final favorites = snapshots
        .map((snapshot) => MovieMapper.mapToEntity(snapshot.value))
        .toList();

    int start = offset;
    int end = offset + limit;
    end = end > favorites.length ? favorites.length : end;
    start = start > end ? end : start;

    return favorites.sublist(start, end);
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(
        filter: Filter.equals('id', movie.id),
      );
      final record = await _store.findFirst(txn, finder: finder);
      if (record == null) {
        // es que no existe, entonces lo agregamos
        final map = MovieMapper.entityToMap(movie);
        await _store.add(txn, map);
      } else {
        // pero si existe, lo eliminamos
        await _store.record(record.key).delete(txn);
      }
    });
  }
}
