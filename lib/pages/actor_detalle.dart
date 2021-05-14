import 'package:flutter/material.dart';
import 'package:infopelis/models/actor_credits_models.dart';
import 'package:infopelis/models/actor_detail_models.dart';
import 'package:infopelis/models/actores_models.dart';
import 'package:infopelis/models/pelicula_model.dart';
import 'package:infopelis/providers/peliculas_provider.dart';


class ActorDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

   final Actor actor = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(
        title: Text('InfoPelis TOP'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: CustomScrollView(
        slivers: <Widget> [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0),
                _posterTitulo( context, actor ),
                _detail( actor ),                
                _credits( actor ),
              ]
            ),
            )

        ],
      )      
    );
  }

  Widget _posterTitulo(BuildContext context, Actor actor){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget> [
          Hero(
            tag: actor.id,        
            child: 
            ClipRRect(borderRadius: BorderRadius.circular(20.0),
                child: Image(
                image: NetworkImage( actor.getProfileImg()),
                height: 150.0,
                ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  actor.name,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  
                  ),
                Row(children: <Widget> [
                  Icon(Icons.star_border),
                  Text(
                    actor.popularity.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  )

                ],)
              ]
            )
            ),

        ],
        ),
      );


  }

  Widget _detail(Actor actor){

    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getActorDetail(actor.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if( snapshot.hasData ){
          return _biografia( snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _biografia(ActorDetail actor){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Wrap(
        spacing: 100, // to apply margin horizontally
        runSpacing: 20, 
        
        children: <Widget>[
          Text(
            actor.biography,
            textAlign: TextAlign.justify
          ),
          // Text(
          // // 'Nombres: ${actor.name}',
          // textAlign: TextAlign.justify
          // ),
          Text(
          'Fecha de Nacimiento: ${actor.birthday}',
          textAlign: TextAlign.justify
          ),
          Text(
          'Lugar de Nacimiento: ${actor.placeOfBirth}',
          textAlign: TextAlign.justify
          ),

        ],
              
      ),
      
    );


  }

  Widget _credits(Actor actor){

    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getActorCredits(actor.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if( snapshot.hasData ){
          return _peliculasPageView( snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _peliculasPageView(List<ActorCredits> peliculas){

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: peliculas.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context, i) => _peliculaTarjeta(context, peliculas[i]),
        ),
    );
  }

  Widget _peliculaTarjeta(BuildContext context, ActorCredits pelicula){   

    return Container(      
      child: Column(
        children: <Widget>[   
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),             
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage( pelicula.getPosterImg()),
                  height: 150.0,
                  fit: BoxFit.cover,
              ),
            
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
          ),
        ],  
      ),
    );


  }
}