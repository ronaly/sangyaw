
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sangyaw_app/pages/all_persons.dart';
import 'package:sangyaw_app/pages/assigned_persons.dart';
import 'package:sangyaw_app/pages/assignments.dart';
import 'package:sangyaw_app/pages/batch_operations.dart';
import 'package:sangyaw_app/pages/batch_update_all_persons.dart';
import 'package:sangyaw_app/pages/batch_update_by_assignments.dart';
import 'package:sangyaw_app/pages/batch_update_by_territories.dart';
import 'package:sangyaw_app/pages/clear_image_cache.dart';

import 'package:sangyaw_app/pages/home.dart';
import 'package:sangyaw_app/pages/about.dart';
import 'package:sangyaw_app/pages/person_details.dart';
import 'package:sangyaw_app/pages/person_form.dart';
import 'package:sangyaw_app/pages/template.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/pages/territories.dart';
import 'package:sangyaw_app/pages/territory_persons.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:sangyaw_app/redux/reducers.dart';
import 'package:sangyaw_app/pages/search_by_facebook.dart';
import 'package:sangyaw_app/pages/search_by_assigned_to.dart';
import 'package:sangyaw_app/pages/searched_persons.dart';
import 'package:sangyaw_app/pages/edit_person.dart';

void main() {
  final _initialState = AppState();
  final _store = Store<AppState>(
    reducer,
    initialState: _initialState,
    middleware: [
      thunkMiddleware, // Add to middlewares
      new LoggingMiddleware.printer(),
    ],
  );
  _store.dispatch(loadAPISettings(_store));

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
          '/searched_persons': (context) => SearchedPersons(),
//          '/edit_person': (context) => EditPerson(),
          '/edit_person': (context) => PersonForm(),
          '/territories': (context) => Territories(),
          '/territory_persons': (context) => TerritoryPersons(),
          '/clear_image_cache': (context) => ClearImageCache(),
          '/batch_operations': (context) => BatchOperations(),
          '/batch_update_all': (context) => BatchUpdateAllPersons(),
          '/batch_update_by_territories': (context) => BatchUpdateByTerritories(),
          '/batch_update_by_assignments': (context) => BatchUpdateByAssignments(),


        },
      ),
    );
  }
}