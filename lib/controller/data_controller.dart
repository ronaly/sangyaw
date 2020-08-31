import 'package:redux/redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import '../model/person.dart';
import "dart:collection";

class DataController {
  Store<AppState> store;

  DataController(Store<AppState> store) {
    this.store = store;
  }

  loadMasterList(String directory) {
    store.dispatch(CurrentWorkbook(directory));
    store.dispatch(getMasterList(store));
  }

  List<Person> get masterList =>  store.state.viewMasterList;
  List<Person> get persons =>  store.state.viewMasterList;
  int get totalPersons => store.state.viewMasterList.length;

  List<String> get directories => store.state.viewWorkbooks;

  String get currentDirectory => store.state.viewCurrentWorkbook;

  bool get loading => store.state.viewLoading;

  List<String> get assignToList {
    List<String> arr = [];
    arr = this.persons.map((e) => e.assignedTo.toLowerCase() ).toList();
    List<String> result = LinkedHashSet<String>.from(arr).toList();
    result.sort();
    return result;
  }


} // DataController class




















