
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/app_state.dart';

abstract class AppStatelessWidget extends StatelessWidget {
  Widget buildBody(BuildContext context);

  DataController dataController;
  DataController getDataControler() {
    return dataController;
  }

  DataController get dc => this.getDataControler();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          this.dataController = new DataController(StoreProvider.of<AppState>(context));
          return buildBody(context);
        });
  }

}