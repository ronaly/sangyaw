import 'package:flutter/material.dart';

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
    bool settings = this.dc.currentDirectory == null ||
        this.dc.globals.congregation == null;

    var bottomNavigationBarItem = BottomNavigationBarItem(
        icon: Icon(
          settings ? Icons.storage : Icons.home,
          size: 30,
          color: Colors.white,
        ),
        // ignore: deprecated_member_use
        title: Text(
          settings ? 'Directory List' : 'Home',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        activeIcon: Icon(
          settings ? Icons.storage : Icons.home,
          size: 30,
          color: Colors.white,
        ));
    return BottomNavigationBar(
      items: [
        bottomNavigationBarItem,
        BottomNavigationBarItem(
            icon: Icon(
              settings ? Icons.settings : Icons.search,
              size: 30,
              color: Colors.white,
            ),
            // ignore: deprecated_member_use
            title: Text(
              settings ? 'Settings' : 'Search Facebook Name',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            activeIcon: Icon(
              settings ? Icons.settings : Icons.search,
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
        if (this.dc.currentDirectory == null ||
            this.dc.globals.congregation == null) {
          Navigator.pushNamed(localContext, '/settings');
          break;
        }
        Navigator.pushNamed(localContext, '/search_facebook');
        break;
    } //end switch
  } //onTabTapped

} //BottomMenu class
