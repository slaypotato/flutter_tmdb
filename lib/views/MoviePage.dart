import 'package:flutter/material.dart';
import '../controllers/MovieController.dart';
import '../core/constants.dart';
import '../widgets/CenteredProgress.dart';
import '../widgets/MovieCard.dart';
import 'MovieDetailPage.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late MovieController _controller = MovieController();
  late ScrollController _scrollController = ScrollController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _initialize();
  }

  _initScrollListener() {
    _scrollController.addListener(() async {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
        if (_controller.currentPage == lastPage) {
          lastPage++;

          await _controller.fetchAllMovies(page: lastPage);
          setState(() {

          });
        }
      }
    });
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchAllMovies(page: lastPage);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: _buildAppBar(),
      ),
      body: _buildMovieGrid(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(kAppName),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Text(kAppName),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _initialize,
        ),
      ],
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieGrid(),
    );
  }*/

/*  _buildAppBar() {
    return AppBar(
      title: Text(kAppName),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _initialize,
        ),
      ],
    );
  }*/

  _buildMovieGrid() {
    if (_controller.loading) {
      return CenteredProgress();
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(2.0),
      itemCount: _controller.moviesCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.65,
      ),
      itemBuilder: _buildMovieCard,
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];
    return MovieCard(
      posterPath: movie.posterPath,
      onTap: () => _openDetailPage(movie.id),
    );
  }

  _openDetailPage(movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId),
      ),
    );
  }
}