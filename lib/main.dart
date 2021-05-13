import 'package:flutter/material.dart';
import 'package:infopelis/pages/actor_detalle.dart';
import 'package:infopelis/pages/home_page.dart';
import 'package:infopelis/pages/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InfoPelis Top',
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: Colors.black,
      //   accentColor: Colors.white24,
      //   canvasColor: Colors.black,
      // ),
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context ) => HomePage(),
        'detalle' : (BuildContext context ) => PeliculaDetalle(),
        'actor' : (BuildContext context ) => ActorDetalle(),
      } ,
      
    );
  }
}