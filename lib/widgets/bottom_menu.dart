import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';

import 'app_stateful_widget.dart';




class BottomMenu extends StatefulWidget {
  _BottomMenu createState() {
    return _BottomMenu();
  }
}


class _BottomMenu extends AppStatefulWidget<BottomMenu> {
  int _currentIndex = 0;

  BuildContext localContext;

  @override
  Widget buildBody(BuildContext context) {
    localContext = context;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            title: Text('Home',
              style: TextStyle(fontSize: 20,
                  color: Colors.white),
            ),
            activeIcon: Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            )),
        BottomNavigationBarItem(
            icon: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
            ),
            title: Text('Search Facebook Name',
                 style: TextStyle(fontSize: 15,
                   color: Colors.white),
            ),
            activeIcon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            )),
      ], //items
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blueAccent,
      onTap: onTabTapped,
      currentIndex: _currentIndex,
    );
  } //widget build


  void onTabTapped(int index) {

    setState(() {
      _currentIndex = index;
    });


    switch (index) {
      case 0:
        Navigator.pushNamed(localContext, '/');
        break;
      case 1:
        Navigator.pushNamed(localContext, '/search_facebook');
        break;
    } //end switch


  } //onTabTapped


} //BottomMenu class


