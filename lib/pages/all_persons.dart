import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/PersonList.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const spinkit1 = SpinKitRotatingCircle(
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
                    return spinkit1;
                  }
                  return PersonList(list: state.viewMasterList);
                },
            ),
          ),
        );
      });
  }
}