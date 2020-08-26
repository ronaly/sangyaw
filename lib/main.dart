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
       home: MyHome(),


     );

   } // Widget build

} //MyApp

class MyHome extends StatefulWidget {

@override
  State<StatefulWidget> createState(){
    return _HomeState();

}

} //MyHome


class _HomeState extends State<MyHome>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('My Sangyawan App')),
      body: SetBackgroundImage(),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(icon: new Icon(Icons.search), title: new Text('Search Facebook Name')),
          BottomNavigationBarItem(icon: new Icon(Icons.search), title: new Text('Search By Assigned Name')),
        ],  //items
      ),

    ); //scaffold

  } //Widget build




  void onTabTapped(int index) {
    setState (() {
      _currentIndex = index;

    } );
   // print('Current Index $_currentIndex');
  }

} //_HomeState









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