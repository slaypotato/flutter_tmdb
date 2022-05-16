import 'package:dartz/dartz.dart';

import '../errors/MovieError.dart';
import '../models/Movie.dart';
import '../models/MovieResponse.dart';
import '../repositories/MovieRepository.dart';

class MovieController {
  final _repository = MovieRepository();

  late MovieResponse movieResponseModel = MovieResponse();
  late MovieError movieError;
  bool loading = true;

  List<Movie> get movies => movieResponseModel.movies ?? <Movie>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount != 0;
  int get totalPages => movieResponseModel.totalPages ?? 1;
  int get currentPage => movieResponseModel.page ?? 1;

  Future<Either<MovieError, MovieResponse>> fetchAllMovies(
      {int page = 1}) async {
    movieError = MovieError();

    final result = await _repository.fetchAllMovies(page);

    result.fold((error) => movieError = error, (movie) {
      if (movieResponseModel.movies != null) {
        movieResponseModel.page = movie.page;
        movieResponseModel.movies?.addAll(movie.movies!);
      } else {
        movieResponseModel = movie;
      }
    },
    );

    return result;
  }
}