import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sangyaw_app/pages/all_persons.dart';
import 'package:sangyaw_app/pages/assigned_persons.dart';
import 'package:sangyaw_app/pages/assignments.dart';
import 'package:sangyaw_app/pages/manage_assignments.dart';
import 'package:sangyaw_app/pages/manage_assignments_all_persons.dart';
import 'package:sangyaw_app/pages/manage_assignments_by_assignments.dart';
import 'package:sangyaw_app/pages/manage_assignments_by_territories.dart';
import 'package:sangyaw_app/pages/clear_image_cache.dart';

import 'package:sangyaw_app/pages/home.dart';
import 'package:sangyaw_app/pages/about.dart';
import 'package:sangyaw_app/pages/person_details.dart';
import 'package:sangyaw_app/pages/person_form.dart';
import 'package:sangyaw_app/pages/settings_page.dart';
import 'package:sangyaw_app/pages/template.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/pages/territories.dart';
import 'package:sangyaw_app/pages/territory_persons.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:sangyaw_app/redux/reducers.dart';
import 'package:sangyaw_app/pages/search_by_facebook.dart';
import 'package:sangyaw_app/pages/search_by_assigned_to.dart';
import 'package:sangyaw_app/pages/searched_persons.dart';
import 'package:sangyaw_app/utils/app_script_utils.dart';

import 'pages/manage_assignments_by_assigned_persons.dart';
import 'pages/manage_assignments_by_territory_persons.dart';
import 'utils/globals.dart';

Future<void> main() async {
  final _initialState = AppState();
  final _store = Store<AppState>(
    reducer,
    initialState: _initialState,
    middleware: [
      thunkMiddleware, // Add to middlewares
      new LoggingMiddleware.printer(),
    ],
  );

  MyApp app = MyApp(store: _store);
  WidgetsFlutterBinding.ensureInitialized()
    ..attachRootWidget(app)
    ..scheduleWarmUpFrame();
  await AppScriptUtils.inialized();
  Globals globals = new Globals();
  await globals.intializePref();
  _store.dispatch(SetGlobals(globals));
  _store.dispatch(loadAPISettings(_store));

  runApp(app);
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    // print(
    //     'Settings check 2, Global Congregation is set to: ${store.state.viewGlobals.congregation}');
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/about': (context) => About(),
          '/settings': (context) => SettingsPage(),
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
          '/manage_assignments': (context) => ManageAssignments(),
          '/manage_assignments_all': (context) => ManageAssignmentsAllPersons(),
          '/manage_assignments_by_territories': (context) =>
              ManageAssignmentsByTerritories(),
          '/manage_assignments_by_assignments': (context) =>
              ManageAssignemntsByAssignments(),
          '/manage_assignments_by_assigned_persons': (context) =>
              ManageAssignmentsByAssignedPersons(),
          '/manage_assignments_by_territory_persons': (context) =>
              ManageAssignmentsByTerritoryPersons(),
        },
      ),
    );
  }
}
