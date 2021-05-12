import 'dart:async';

import 'package:infopelis/models/actores_models.dart';
import 'package:infopelis/models/pelicula_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PeliculasProvider{


  String _apykey = '147031605709ca421df88292c1efcb31';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = new List(); 

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController.close();
  }

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
    if(_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apykey,
      'language' : _language,
      'page'   : _popularesPage.toString()    
    });

    final resp = await _procesarResp(url);

    _populares.addAll(resp);
    popularesSink( _populares );

    _cargando = false;

    return resp;

  }


  Future <List<Actor>> getReparto(String peliId) async{

    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key' : _apykey,
      'language' : _language      
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final reparto = new Reparto.fromJsonList(decodedData['cast']);  

    return reparto.actores;    

  }

  Future <List<Pelicula>>searchPelicula( String query ) async{   

    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apykey,
      'language' : _language,
      'query' : query   
    });

    return await _procesarResp(url);


  }

  Future <List<ActorDetail>> getActorDetail(String actorId) async{

    final url = Uri.https(_url, '3/person/$actorId', {
      'api_key' : _apykey,
      'language' : _language      
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final actor = new Detail.fromJsonList(decodedData);  

    return actor.items;    

  }

  Future <List<ActorCredits>> getActorCredits(String actorId) async{

    final url = Uri.https(_url, '3/person/$actorId/movie_credits', {
      'api_key' : _apykey,
      'language' : _language      
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final credits = new Credits.fromJsonList(decodedData);  

    return credits.items;    

  }
}