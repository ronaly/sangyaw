import 'dart:collection';

import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:sangyaw_app/utils/app_script_utils.dart';
import 'package:sangyaw_app/utils/globals.dart';

ThunkAction<AppState> loadAPISettings = (Store<AppState> store) {
  store.dispatch(new ClearAppErrors());
  store.dispatch(new Loading(true));
  AppScriptUtils.getSettings().then((List<dynamic> settings) {
    print('============================');
    settings.forEach((setting) {
      print(setting);
    });
    print('============================');
    store.dispatch(new Settings(settings));
    if (AppScriptUtils.getGoogleSheetNames(store) != null) {
      store.dispatch(new Workbooks(AppScriptUtils.getGoogleSheetNames(store)));
    }
    store.dispatch(new Loading(false));
  }).catchError((err) {
    store.dispatch(
        new CreateAppError('Internet Connection Failed', err.toString()));
    store.dispatch(new MasterList(new SplayTreeMap<int, Person>()));
    store.dispatch(new Settings([]));
  });
};

ThunkAction<AppState> getMasterList = (Store<AppState> store) {
  store.dispatch(new ClearAppErrors());
  store.dispatch(new Loading(true));
  return AppScriptUtils.getMasterList(AppScriptUtils.getGoogleSheetId(store))
      .then((List<Person> persons) {
    SplayTreeMap<int, Person> personsMap =
        SplayTreeMap.fromIterable(persons, key: (e) => e.id, value: (e) => e);
    store.dispatch(new MasterList(personsMap));
    store.dispatch(new Loading(false));
  }).catchError((err) {
    store.dispatch(
        new CreateAppError('Internet Connection Failed', err.toString()));
    store.dispatch(new MasterList(new SplayTreeMap<int, Person>()));
  });
};

class SetGlobals {
  final Globals payload;
  SetGlobals(this.payload);
}

class Settings {
  final dynamic payload;
  Settings(this.payload);
}

class Workbooks {
  final List<String> payload;
  Workbooks(this.payload);
}

class CurrentWorkbook {
  final String payload;
  CurrentWorkbook(this.payload);
}

class MasterList {
  final SplayTreeMap<int, Person> payload;
  MasterList(this.payload);
}

class Loading {
  final bool payload;
  Loading(this.payload);
}

class CurrentPerson {
  final Person payload;
  CurrentPerson(this.payload);
}

class NewPerson {
  final Person payload;
  NewPerson(this.payload);
}

class CurrentAssigned {
  final String payload;
  CurrentAssigned(this.payload);
}

class AppError {
  final bool payload;
  AppError(this.payload);
}

class AppErrorTitle {
  final String payload;
  AppErrorTitle(this.payload);
}

class AppErrorMessage {
  final String payload;
  AppErrorMessage(this.payload);
}

class ClearAppErrors {
  ClearAppErrors();
}

class CreateAppError {
  final String title;
  final String message;
  CreateAppError(this.title, this.message);
}

class QueryTerm {
  final String payload;
  QueryTerm(this.payload);
}

class UpdatePersonToMasterList {
  final Person payload;
  UpdatePersonToMasterList(this.payload);
}

class AddPersonToMasterList {
  final Person payload;
  AddPersonToMasterList(this.payload);
}

class UpdateAssignments {
  String assignTo;
  List<int> ids;
  UpdateAssignments(this.assignTo, this.ids);
}
