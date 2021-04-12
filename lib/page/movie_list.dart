import 'package:flutter/material.dart';
import 'package:tugas_http/service/http_service.dart';
import 'package:tugas_http/page/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String imgPath = 'https://image.tmdb.org/t/p/w500/';
  int moviesCount;
  List movies;
  HttpService service;

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String path;

    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
        backgroundColor: Colors.blueGrey[800],
      ),
       backgroundColor:Colors.blueGrey[900],
      body: Container(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (context, int position) {
              return Card(
                color: Colors.blueGrey[800],
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => MovieDetail(movies[position]));
                    Navigator.push(context, route);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage(imgPath + movies[position].posterPath),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: 5, right: 5),
                    child: Text(
                    movies[position].voteAverage.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
