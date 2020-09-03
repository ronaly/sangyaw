import 'dart:convert';

import 'package:sangyaw_app/config/config.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:http/http.dart' as http;
import 'package:sangyaw_app/utils/app_script_utils.dart';



ThunkAction<AppState> loadAPISettings = (Store<AppState> store) async {

  store.dispatch(new ClearAppErrors());


  try {
    store.dispatch(new Loading(true));

    List<dynamic> settings = await AppScriptUtils.getSettings();

    store.dispatch(new Settings(settings));
    store.dispatch(new Workbooks(AppScriptUtils.getGoogleSheetNames(store)));

    store.dispatch(new Loading(false));

  } catch (err) {
    store.dispatch(new CreateAppError('Internet Connection Failed', err.toString()));
    store.dispatch(new MasterList([]));
    store.dispatch(new Settings([]));
  }
};

ThunkAction<AppState> getMasterList = (Store<AppState> store) async {

  store.dispatch(new ClearAppErrors());

  try {
    store.dispatch(new Loading(true));

    List<Person> persons = await AppScriptUtils.getMasterList(AppScriptUtils.getGoogleSheetId(store));

    store.dispatch(new MasterList(persons));
    store.dispatch(new Loading(false));

  } catch (err) {
    store.dispatch(new CreateAppError('Internet Connection Failed', err.toString()));
    store.dispatch(new MasterList([]));
  }
};

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
  final List<Person> payload;
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

