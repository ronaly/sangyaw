
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sangyaw_app/pages/all_persons.dart';
import 'package:sangyaw_app/pages/assigned_persons.dart';
import 'package:sangyaw_app/pages/assignments.dart';

import 'package:sangyaw_app/pages/home.dart';
import 'package:sangyaw_app/pages/about.dart';
import 'package:sangyaw_app/pages/person_details.dart';
import 'package:sangyaw_app/pages/template.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/reducers.dart';
import 'package:sangyaw_app/pages/search_by_facebook.dart';
import 'package:sangyaw_app/pages/search_by_assigned_to.dart';

void main() {
  final _initialState = AppState(workbooks: ['Pamutan', 'Tuong'], masterList: [], loading: false);
  final _store = Store<AppState>(
    reducer,
    initialState: _initialState,
    middleware: [
      thunkMiddleware, // Add to middlewares
      new LoggingMiddleware.printer(),
    ],
  );

  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/about': (context) => About(),
          '/template': (context) => Template(),
          '/all': (context) => AllPersons(),
          '/search_facebook': (context) => SearchByFacebook(),
          '/search_assigned_to': (context) => SearchByAssignedTo(),
          '/assignments': (context) => Assignments(),
          '/assigned_persons': (context) => AssignedPersons(),
          '/person_details': (context) => PersonDetails(),
        },
      ),
    );
  }
}