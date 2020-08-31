
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'drawer_menu.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLayoutContainer extends StatelessWidget {
  Widget child;
  String title;

  AppLayoutContainer({this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(this.title),
              backgroundColor: Colors.teal,
            ),
            drawer: DrawerMenu(),
            bottomNavigationBar: BottomNavigationBar(),
            body: Container(
                margin: EdgeInsets.all(10.0),
                child: state.viewLoading ? this.getSpinner() : this.child
            ),
          );
        });
  }

  final spinkit1 = SpinKitRotatingCircle(
    color: Colors.blueAccent,
    size: 50.0,
  );
  final spinkit2 = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );


  Widget getSpinner() {
    return spinkit1;
  }
}
