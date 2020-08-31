import 'dart:async';
import 'dart:convert';

import 'package:sangyaw_app/controller/data_controller.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


// Google App Script Web URL.
const String URL_Pamutan = "https://script.google.com/macros/s/AKfycbwsKt8R9yIWp_vMpCxxDmZlhSBFMJp2T5MZmLp7vi_B760KfVM/exec";
const String URL_Toong = "https://script.google.com/macros/s/AKfycbw2Xz2F_okd_ciCHavm57HalTdDrE3V1aiYg-6Zi6qegvZJioo/exec";
//Success Status Message
const STATUS_SUCCESS = "SUCCESS";


//ThunkAction<AppState> getMasterList() {
//  print('Get Master List is called');
//  return (Store<AppState> store) async {
//    print('Assync is called for getMAsterList');
//    List<Person>  arr = await getMasterListFromPamutan();
//    print(arr);
//    store.dispatch(new MasterList(arr));
//  };
//}


ThunkAction<AppState> getMasterList2(Completer completer) { // Define the parameter
  print('ThunkAction is called');
  return (Store<AppState> store) async {
    print('ThunkAction is called 22222222222');
    try {
      List<Person>  arr = await getMasterListFromPamutan();
      store.dispatch(new MasterList(arr));
      completer.complete();   // No exception, complete without error
    } on Exception catch (e) {
      completer.completeError(e);   // Exception thrown, complete with error
    }
  };
}


ThunkAction<AppState> getMasterList = (Store<AppState> store) async {

  http.Response response = await http.get(
    Uri.encodeFull(URL_Pamutan),
  );
  List result = json.decode(response.body) as List;
  print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
  print(result);
  print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
  List<Person> persons = result.map((json){
    print('Person Json: ' + json.toString());
    return Person.fromJson(json);
  }).toList();

  store.dispatch(
      new MasterList(persons)
  );
};

Future<List<Person>> getMasterListFromPamutan() async {
  print('Gets Pamutan from site');
  final response = await http.get(URL_Pamutan);
  var jsonList = convert.jsonDecode(response.body) as List;
  return jsonList.map((json) => Person.fromJson(json)).toList();
} //getMasterListFromPamutan

Future<List<Person>> getMasterListFromToong() async {
  print('Gets Toong from site');
  final response = await http.get(URL_Toong);
  var jsonList = convert.jsonDecode(response.body) as List;
  return jsonList.map((json) => Person.fromJson(json)).toList();
} //getMasterListFromToong


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
