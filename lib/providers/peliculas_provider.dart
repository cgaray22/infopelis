import 'package:infopelis/models/pelicula_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PeliculasProvider{


  String _apykey = '147031605709ca421df88292c1efcb31';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _procesarResp(Uri url) async{

      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);


      final peliculas = new Peliculas.fromJsonList(decodedData['results']);    

      return peliculas.items;


  }

  Future <List<Pelicula>>getCartelera() async{

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apykey,
      'language' : _language    
    });

    return await _procesarResp(url);

  }

  Future <List<Pelicula>>getPopular() async{

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apykey,
      'language' : _language    
    });

    return await _procesarResp(url);

  }





}