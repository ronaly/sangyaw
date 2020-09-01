import 'dart:convert';

import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:http/http.dart' as http;


// Google App Script Web URL.
String getGoogleSheetApiUrl(Store<AppState> store) {
  const String URL_Pamutan = "https://script.google.com/macros/s/AKfycbwsKt8R9yIWp_vMpCxxDmZlhSBFMJp2T5MZmLp7vi_B760KfVM/exec";
  const String URL_Toong = "https://script.google.com/macros/s/AKfycbw2Xz2F_okd_ciCHavm57HalTdDrE3V1aiYg-6Zi6qegvZJioo/exec";
  //Success Status Message
  const STATUS_SUCCESS = "SUCCESS";

  if('Pamutan' == store.state.currentWorkbook) {
    return URL_Pamutan;
  }

  if('Tuong' == store.state.currentWorkbook) {
    return URL_Pamutan;
  }

  return 'https://lsdjflsdjflsdflsdfjldks/';
}


ThunkAction<AppState> getMasterList = (Store<AppState> store) async {

  store.dispatch(new ClearAppErrors());

  String url = getGoogleSheetApiUrl(store);
  try {
    store.dispatch(new Loading(true));
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

