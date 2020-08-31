
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'drawer_menu.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class AppLayoutContainer extends StatelessWidget {
  String getTitle(context, AppState state);
  Widget buildBody(context, AppState state);

  DataController dataController;
  DataController getDataControler() {
    return dataController;
  }

  get dc => this.getDataControler();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          this.dataController = new DataController(StoreProvider.of<AppState>(context));
          return Scaffold(
            appBar: AppBar(
              title: Text(this.getTitle(context, state)),
              backgroundColor: Colors.teal,
            ),
            drawer: DrawerMenu(),
            body: Container(
                margin: EdgeInsets.all(10.0),
                child: state.viewLoading ? getSpinner() : this.buildBody(context, state)
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
