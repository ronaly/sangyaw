import 'dart:convert';

import 'package:sangyaw_app/config/config.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:http/http.dart' as http;


// Google App Script Web URL.
//const String APP_SCRIPT_URL = 'https://script.google.com/macros/s/AKfycbwsKt8R9yIWp_vMpCxxDmZlhSBFMJp2T5MZmLp7vi_B760KfVM/exec';

String getSangyawAppFolderInstance() {
  // TODO: in the future make this one dynamic based on user settings
  return 'BucaweCong';
}

String getGoogleSheetId(Store<AppState> store) {
  List settings = store.state.viewSettings;
  String current = store.state.viewCurrentWorkbook;
  return getSangyawSheetMap(store)[current];
}

dynamic getSangyawSettingstMap(Store<AppState> store) {

  List settings = store.state.viewSettings;
  String instance = getSangyawAppFolderInstance();
  dynamic setting = settings.firstWhere((element) => element['folderName'] == instance);

  return setting;
}

Map<String, String> getSangyawSheetMap(Store<AppState> store) {
  Map<String, String> map = {};

  List settings = store.state.viewSettings;
  String instance = getSangyawAppFolderInstance();
  dynamic setting = settings.firstWhere((element) => element['folderName'] == instance);
  if( setting['sheets'] != null) {
    (setting['sheets'] as List).forEach((e) {
      map[e['fileName']] = e['fileId'];
    });
  }
  return map;
}

List<String> getGoogleSheetNames(Store<AppState> store) {
  return getSangyawSheetMap(store).keys.toList();
}

String getGoogleSheetApiUrl(Store<AppState> store) {
  String sheetId = getGoogleSheetId(store);
  return '$APP_SCRIPT_URL?action=listPersons&sheetId=${sheetId}';
}


ThunkAction<AppState> loadAPISettings = (Store<AppState> store) async {

  store.dispatch(new ClearAppErrors());

  String url = '$APP_SCRIPT_URL?action=settings';
  try {
    store.dispatch(new Loading(true));
    print(url);
    http.Response response = await http.get(
      Uri.encodeFull(url),
    );

    List result = json.decode(response.body) as List;
    List<dynamic> settings = result.map((json){
      List sheets = json['sheets'];
      return {
        'folderId': json['folderId'],
        'folderName': json['folderName'],
        'sheets' : sheets,
      };
    }).toList();
    store.dispatch(new Settings(settings));
    store.dispatch(new Workbooks(getGoogleSheetNames(store)));

    store.dispatch(new Loading(false));

  } catch (err) {
    store.dispatch(new CreateAppError('Internet Connection Failed', err.toString()));
    store.dispatch(new MasterList([]));
    store.dispatch(new Settings([]));
  }
};

ThunkAction<AppState> getMasterList = (Store<AppState> store) async {

  store.dispatch(new ClearAppErrors());

  String url = getGoogleSheetApiUrl(store);
  try {
    store.dispatch(new Loading(true));
    print(url);
    http.Response response = await http.get(
      Uri.encodeFull(url),
    );

    List result = json.decode(response.body) as List;
    List<Person> persons = result.map((json){
      return Person.fromJson(json);
    }).toList();

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

