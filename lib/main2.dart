
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sangyaw_app/all_persons.dart';

import 'package:sangyaw_app/home.dart';
import 'package:sangyaw_app/about.dart';
import 'package:sangyaw_app/settings.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/reducers.dart';

void main() {
  final _initialState = AppState(workbooks: ['Pamutan', 'Tuong'], masterList: []);
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
          '/settings': (context) => Settings(),
          '/all': (context) => AllPersons(),
        },
      ),
    );
  }
}