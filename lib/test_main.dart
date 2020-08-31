import 'package:flutter/material.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/master_form.dart';

void main() => runApp(MyApp());

//global
int _selectedDirectory = 0;

// this navigator state will be used to navigate different pages
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
List<MasterForm> bucaweItems = List<MasterForm>();

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


class _HomeState extends State<MyHome> {


  int _currentIndex = 0;
  TextEditingController facebookNameController = TextEditingController();
  TextEditingController assignedNameController = TextEditingController();



  // @override
  // void initState() {
  //   super.initState();
  //
  //   FormController().getDataFromBucaweForm().then((bucaweItems) {
  //
  //     setState(() {
  //       this.bucaweItems = bucaweItems;
  //     });
  //   }); //FormController
  // } //initState




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Sangyawan App')),
      resizeToAvoidBottomPadding: false,
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.search),
              title: new Text('Search Facebook Name')),
          BottomNavigationBarItem(icon: new Icon(Icons.search),
              title: new Text('Search By Assigned Name')),
        ], //items
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
       //
      ),
      body: Navigator(key: _navigatorKey, onGenerateRoute: generateRoute),
    ); //scaffold
  } //Widget build


  void _onTabTapped(int index) {
    switch (index) {
      case 0:
        //_navigatorKey.currentState.pushReplacementNamed("Search_Facebook");
        _navigatorKey.currentState.pushNamedAndRemoveUntil("Search_Facebook", (route) => false);
        break;
      case 1:
        //_navigatorKey.currentState.pushReplacementNamed("Search_Assigned");
        _navigatorKey.currentState.pushNamedAndRemoveUntil("Search_Assigned", (route) => false);
        break;
    } //end switch
    setState (() {
      _currentIndex = index;
    } );
   // print('Current Index $_currentIndex');
  } //onTabTapped

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case "Search_Facebook":
        return MaterialPageRoute(builder: (context) => facebookSection);
      case "Search_Assigned":
        return MaterialPageRoute(builder: (context) => assignedSection);
      case "PamutanMasterRefreshed":
        return MaterialPageRoute(builder: (context) => refreshButton);
      default:
        return MaterialPageRoute(builder: (context) => facebookSection);
    } //switch

  } //route

  Widget facebookSection = new Container (
   child: Center (
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget> [
        Form(
            child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    TextFormField(
                     // controller: facebookNameController.,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Facebook Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Enter Facebook Name:'),
                    )
                  ],
                )
            )
        )
      ],
    )
   )
  );  //container


  Widget assignedSection = new Container (
    child: Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Form(
              child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      TextFormField(
                       // controller: assignedNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Assigned Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Enter Assigned Name:'),
                      )
                    ],
                  )
              )
          )
        ],
      )
    )
  );  // widget assignedSection



  Widget refreshButton = new Container (
    child: Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           RaisedButton(
            child: Text('Tap Me to Refresh your Local MasterList',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.normal)),
            color: Colors.blue,
            textColor: Colors.black,
            onPressed: onRefresh,
              //onPressed
          )
        ], //[] children
      ),
    ),
  ); // widget refreshButton


  onRefresh() {

    // FormController().getDataFromMasterForm().then((masterItems) {
    //
    //   setState(() {
    //     //    this.masterItems = masterItems;
    //     print('Running getJsonDataFrom Master Form');
    //   }),
    //
    // }; //FormController
    print('entering refreshMasterList');
  } //onRefresh




} // _HomeState



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
  _navigatorKey.currentState.pushReplacementNamed("PamutanMasterRefreshed");
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