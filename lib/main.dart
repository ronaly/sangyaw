import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
   @override
    Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Sangyaw',
       theme: ThemeData(
        primarySwatch: Colors.blue,
       ),
       home: MyMainPage(),


     );

   } // Widget build

} //MyApp

class MyMainPage extends StatelessWidget {

@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Sangyawan App')),
      body: SetBackgroundImage(),
      drawer: MyDrawer(),



    ); //scaffold



} //Widget build

} //MyMainPage

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      //adding ListView to the drawer
        child: ListView(
          //important: remove any padding from the ListView
          padding: EdgeInsets.zero,
          children: <Widget> [
            DrawerHeader(
              child: Text('Choose Directory',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 6, fontSize: 28)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            ListTile(
              title: Text('Pamutan Directory',
                textAlign: TextAlign.center,
                  style: TextStyle(height: 4, fontSize: 20)),
              onTap: () {
                // update the state of the app
                // ....
                // Then close the drawer
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('Toong Directory',
                textAlign: TextAlign.center,
                  style: TextStyle(height: 4, fontSize: 20)
              ),
              onTap: () {
                // update the state of the app
                // ....
                // Then close the drawer
                Navigator.pop(context);
              },
            ),


          ],

        )

    ); //Drawer

  }  // widget build

} //MyDrawer


class SetBackgroundImage extends StatelessWidget {

  @override
  Widget build(BuildContext context){

     return Container(
       constraints: BoxConstraints.expand(),
       decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage("assets/images/background.png"),
           fit: BoxFit.fill,
         ),
       ),


     ); //container







  } // Widget build




} //SetBackgroundImage