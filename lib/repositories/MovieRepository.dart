import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../core/Api.dart';
import '../errors/MovieError.dart';
import '../models/MovieDetail.dart';
import '../models/MovieResponse.dart';

class MovieRepository {
  final Dio _dio = Dio(kDioOptions);

  Future<Either<MovieError, MovieResponse>> fetchAllMovies(int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page&language=pt-BR');
      final model = MovieResponse.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response!.data['status_message']));
      } else {
        return Left(MovieRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieDetail>> fetchMovieById(int id) async {
    try {
      final response = await _dio.get('/movie/$id?language=pt-BR');
      final model = MovieDetail.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response!.data['status_message']));
      } else {
        return Left(MovieRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }
}