import 'package:dio/dio.dart';

const kBaseUrl = 'https://api.themoviedb.org/3';
const kApiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTkyOGIyM2EwZjYyMjRiMjRlOGZmZjgyZGY5OGRlYyIsInN1YiI6IjYyN2Q1NTA2MDA2ZWVlMTUwMjg4YWE5YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wWE4C_FR5Zizxjo4l6XehX_ztR4GCKej5cHWCdGSTZM';

const kServerError = 'Failed to connect to the server. Try again later.';
final kDioOptions = BaseOptions(
  baseUrl: kBaseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000,
  contentType: 'application/json;charset=utf-8',
  headers: {'Authorization': 'Bearer $kApiKey'},
);