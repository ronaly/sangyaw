import 'package:flutter/material.dart';
import 'package:sangyaw_app/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/PersonList.dart';
import 'package:sticky_headers/sticky_headers.dart';

class AllPersons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Found ${state.masterList.length} Persons in ${state.currentWorkbook}'),
              backgroundColor: Colors.teal,
            ),
            drawer: DrawerMenu(),
            body: Container(
              margin: EdgeInsets.all(10.0),
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  if (state.viewLoading) {
                    return new WillPopScope(
                        onWillPop: () async => false,
                        child: SimpleDialog(
                            key: key,
                            backgroundColor: Colors.black54,
                            children: <Widget>[
                              Center(
                                child: Column(children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 10,),
                                  Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                                ]),
                              )
                            ]));
                  }
                  return PersonList(list: state.viewMasterList);
                },
            ),
          ),
        );
      });
  }
}