import 'package:flutter/material.dart';
import 'package:infopelis/providers/peliculas_provider.dart';
import 'package:infopelis/widgets/card_swiper_widget.dart';
import 'package:infopelis/widgets/movie-horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {   
    peliculasProvider.getPopular(); 
    return Scaffold(
      appBar: AppBar(
        title: Text('InfoPelis TOP'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ), 
            onPressed: (){
              // showSearch();

            }
            )

        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _estrenos(),
            _populares(context)

          ]

        ),
      )
      

    );  
   
  }
  Widget _estrenos(){

    return FutureBuilder(
      future: peliculasProvider.getCartelera(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData){
          return CardSwiper(peliculas: snapshot.data);
        } else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
              )
            );
        }
        
      },
    );   
  }

  Widget _populares(BuildContext context){
    return Container(
      width: double.infinity,      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
            ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopular,

                  );
              } else {
                return Center(child: CircularProgressIndicator());
              }              
            },
          ),

        ]
      ),
    );

  }
}