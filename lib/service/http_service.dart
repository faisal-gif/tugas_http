import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tugas_http/models/movie.dart';
class HttpService {
  final String apiKey ='8f256820243cb283c155d2c1d9dd9d0a';
  final String baseUrl ='https://api.themoviedb.org/3/movie/popular?api_key=';

Future<List> getPopularMovies() async{
  final String uri = baseUrl + apiKey;

  http.Response result = await http.get(Uri.parse(uri));
if(result.statusCode == HttpStatus.ok){
  print("Sukses");
  final jsonResponse = json.decode(result.body);
  final moviesMap = jsonResponse['results'];
  List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
  return movies;
}
else{
  print("Fail");
  return null;
}
}

}