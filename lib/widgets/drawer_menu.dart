import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/widgets/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';

const headerTitle = 'Directory';

class DrawerMenu extends StatelessWidget {
  DataController dataController;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          this.dataController = new DataController(StoreProvider.of<AppState>(context));
          return ListView(
            padding: EdgeInsets.zero,
            children: getWidgets(context, state),
          );
        },
      ),
    );
  }

  List<Widget> getWidgets(context, AppState state) {
    List<Widget> arr =  <Widget>[
      DrawerHeader(
        child: Center(
          child: Text(
            headerTitle,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.title.fontSize,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
      ),
    ];

    state.viewWorkbooks.forEach((workbook) {
      arr.add(getListTile(workbook, workbook == state.viewCurrentWorkbook, onTap: () {
//        StoreProvider.of<AppState>(context)
//            .dispatch(CurrentWorkbook(workbook));
//
//        StoreProvider.of<AppState>(context).dispatch(getMasterList( StoreProvider.of<AppState>(context)));

        this.dataController.loadMasterList(workbook);
        Navigator.pushNamed(context, '/');
      }));
      arr.add(getLine());

    });

    return arr;

  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget getListTile(String title, bool isSelected, {Function onTap}) {
    return ListTile(
      leading: Icon(Icons.terrain),
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
      selected: isSelected,
      subtitle: Text('e-click, aron maka sangyaw sa taga ${title}'),
      onTap: onTap,
    );
  }

//  Function gotoScreen(BuildContext context, String name) {
//    if (name == 'home') {
//      Navigator.pushNamed(context, '/');
//    } else if (name == 'about') {
//      Navigator.pushNamed(context, '/about');
//    } else if (name == 'settings') {
//      Navigator.pushNamed(context, '/settings');
//    }
//  }
}