
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/utils/spinner.dart';
import 'drawer_menu.dart';
import 'bottom_menu.dart';

abstract class AppStatefulLayoutContainer<T extends StatefulWidget> extends State<T> {

  final _loadingTitle = 'Loading please wait ...';

  String getTitle(context, AppState state);
  Widget buildBody(context, AppState state);


  DataController dataController;
  DataController getDataController() {
    return dataController;
  }

  DataController get dc => this.getDataController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          this.dataController = new DataController(StoreProvider.of<AppState>(context));
          Widget renderMe;
          String strTitle;

          if(this.dc.error) {
            strTitle = this.dc.errorTitle;
            renderMe = Text(this.dc.errorMessage);
          } else if(this.dc.loading) {
            strTitle = _loadingTitle;
            return getAppSpinner();
          } else if(this.dc.currentDirectory == null) {
            renderMe = Container(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RichText(
                text: TextSpan(
                  text: 'Please select a Directory!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlue,
                  ),
                ),
              ),

            );
            strTitle = 'Please select a Directory';
          } else {
            renderMe = this.buildBody(context, state);
            strTitle = this.getTitle(context, state);
          }
          return Scaffold(
            appBar: AppBar(
              title: RichText(
                text: TextSpan(
                  text: strTitle,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            drawer: DrawerMenu(),
            bottomNavigationBar: BottomMenu(),
            body: Container(
                margin: EdgeInsets.all(10.0),
                child: renderMe
            ),
          );
        });
  }

}
