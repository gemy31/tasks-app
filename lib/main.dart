import 'package:flutter/material.dart';
import 'package:to_do_app/home/home_screen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.Route_Name : (context) => HomeScreen(),

      },
      initialRoute: HomeScreen.Route_Name,

    );
  }
}