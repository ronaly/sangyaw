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


ThunkAction<AppState> getMasterList = (Store<AppState> store) async {
  store.dispatch(
      new Loading(true)
  );
  String url = store.state.currentWorkbook == 'Pamutan' ? URL_Pamutan  : URL_Toong;
  http.Response response = await http.get(
    Uri.encodeFull(url),
  );
  List result = json.decode(response.body) as List;
  List<Person> persons = result.map((json){
    print('Person Json: ' + json.toString());
    return Person.fromJson(json);
  }).toList();

  store.dispatch(
      new MasterList(persons)
  );
  store.dispatch(
      new Loading(false)
  );
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
