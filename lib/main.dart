import 'package:flutter/material.dart';
import 'package:sangyaw_app/bucawe_view.dart';

void main() => runApp(MyApp());

//global
int _selectedDirectory = 0;


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

  TextEditingController facebookNameController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('My Sangyawan App')),
      resizeToAvoidBottomPadding: false,
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(icon: new Icon(Icons.search), title: new Text('Search Facebook Name')),
          BottomNavigationBarItem(icon: new Icon(Icons.search), title: new Text('Search By Assigned Name')),
        ],  //items
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Form(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          TextFormField(
                            controller: facebookNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Facebook Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Facebook Name'),
                          )
                        ],
                      )
                  )

              )
            ],
          )
      ),
    ); //scaffold
  } //Widget build





  void onTabTapped(int index) {
    setState (() {
      _currentIndex = index;

    } );
   // print('Current Index $_currentIndex');
  } //onTabTapped

} //_HomeState






//class SearchAssignedForm extends StatelessWidget {


//} //SearchAssignedForm





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
                  style: TextStyle(fontSize: 24)),
            ),

            ListTile(
              title: Text('Pamutan Directory',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                selectedDirectory(0);
                // close the drawer
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('Toong Directory',
                textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                selectedDirectory(1);
                // close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        )
    ); //Drawer
  }  // widget build
} //MyDrawer

void selectedDirectory (int index) {
  _selectedDirectory = index;

  // 0 - Pamutan Directory;
  // 1 - Toong Directory;

  print ('Selected Directory: $_selectedDirectory');
}







// class SetBackgroundImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//      return Container(
//        constraints: BoxConstraints.expand(),
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/images/background.png"),
//            fit: BoxFit.fill,
//          ),
//        ),
//      ); //container
//   } // Widget build
// } //SetBackgroundImage