import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';

// class LocalState extends StatefulWidget {
//   BottomMenu createState() {
//     return BottomMenu();
//   }
// }

class BottomMenu extends StatelessWidget {

  int _currentIndex = 1;
  BuildContext localContext;

  @override
  Widget build(BuildContext context) {
    localContext = context;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: new Icon(Icons.search),
            title: new Text('Search Facebook Name')),
        BottomNavigationBarItem(icon: new Icon(Icons.assignment_ind),
            title: new Text('Assignments')),
      ], //items
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blueAccent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      onTap: onTabTapped,
      currentIndex: _currentIndex,

    );
  } //widget build


  void onTabTapped(int index) {


    switch (index) {
      case 0:
       // Navigator.pushReplacementNamed(localContext, '/search_facebook');
        Navigator.pushNamedAndRemoveUntil(localContext, '/search_facebook', (route) => false);
        _currentIndex = index;

        break;
      case 1:
        //Navigator.pushReplacementNamed(localContext, '/search_assigned_to');
        Navigator.pushNamedAndRemoveUntil(localContext, '/assignments', (route) => false);

        break;
    } //end switch

     // setState(() {
     //   _currentIndex = index;
     // });
     print('Current Index $_currentIndex');
  } //onTabTapped


} //BottomMenu class


