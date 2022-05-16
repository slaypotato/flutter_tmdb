import 'package:dartz/dartz.dart';

import '../errors/MovieError.dart';
import '../models/MovieDetail.dart';
import '../repositories/MovieRepository.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  late MovieDetail movieDetail = MovieDetail();
  late MovieError movieError = MovieError();

  bool loading = true;

  Future<Either<MovieError, MovieDetail>> fetchMovieById(int id) async {
    movieError = MovieError();

    final result = await _repository.fetchMovieById(id);

    result.fold(
          (error) => movieError = error,
          (detail) => movieDetail = detail,
    );

    return result;
  }
}