import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';


class BottomMenu extends StatelessWidget {
  int _currentIndex = 0;
  BuildContext localContext;

  @override
  Widget build(BuildContext context) {
    localContext = context;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: new Icon(Icons.search),
            title: new Text('Search Facebook Name')),
        BottomNavigationBarItem(icon: new Icon(Icons.search),
            title: new Text('Search By Assigned Name')),
      ], //items
      onTap: onTabTapped,
      currentIndex: _currentIndex,

    );
  } //widget build


  void onTabTapped(int index) {
    _currentIndex = index;

    switch (index) {
      case 0:
       // Navigator.pushReplacementNamed(localContext, '/search_facebook');
        Navigator.pushNamedAndRemoveUntil(localContext, '/search_facebook', (route) => false);

        break;
      case 1:
        //Navigator.pushReplacementNamed(localContext, '/search_assigned_to');
        Navigator.pushNamedAndRemoveUntil(localContext, '/search_assigned_to', (route) => false);
        break;
    } //end switch

     print('Current Index $_currentIndex');
  } //onTabTapped


} //BottomMenu class


