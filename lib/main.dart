import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
   @override
    Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Sangyaw',
       theme: ThemeData(
        primarySwatch: Colors.green,
       ),
       home: MyDrawer(),


     );

   } // Widget build

} //MyApp

class MyDrawer extends StatelessWidget {

@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Sangyawanan')),
      body: Center(child: Text('My Page')),
      drawer: Drawer(
          //adding ListView to the drawer
        child: ListView(
              //important: remove any padding from the ListView
          padding: EdgeInsets.zero,
          children: <Widget> [
            DrawerHeader(
                 child: Text('Sangyawanan Menu'),
                 decoration: BoxDecoration(color: Colors.yellow),
            ),

            ListTile(
              title: Text('Pamutan Directory'),
              onTap: () {
                // update the state of the app
                // ....
                // Then close the drawer
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('Toong Directory'),
              onTap: () {
                // update the state of the app
                // ....
                // Then close the drawer
                Navigator.pop(context);
              },
            ),


          ],

        ),

      ),




    ); //scaffold



} //Widget build







} //MyDrawer