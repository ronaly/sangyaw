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

  List<Person> get masterList =>  store.state.viewMasterList;
  List<Person> get persons =>  store.state.viewMasterList;
  int get totalPersons => store.state.viewMasterList.length;

  List<String> get directories => store.state.viewWorkbooks;

  String get currentDirectory => store.state.viewCurrentWorkbook;

  bool get loading => store.state.viewLoading;

  Person get currentPerson => store.state.viewCurrentPerson;
  Person get newPerson => store.state.viewNewPerson;
  String get currentAssigned => store.state.viewCurrentAssigned;

  bool get error => store.state.appError;
  String get errorTitle => store.state.appErrorTitle;
  String get errorMessage => store.state.appErrorMessage;

  set currentPerson(Person person) {
    store.dispatch(CurrentPerson(person));
  }

  set newPerson(Person person) {
    store.dispatch(NewPerson(person));
  }

  set currentAssigned(String currentAssigned) {
    store.dispatch(CurrentAssigned(currentAssigned));
  }

  set error(bool error) {
    store.dispatch(AppError(error));
  }

  set errorTitle(String title) {
    store.dispatch(AppErrorTitle(title));
  }

  set errorMessage(String message) {
    store.dispatch(AppErrorMessage(message));
  }


  loadMasterList(String directory) {
    store.dispatch(CurrentWorkbook(directory));
    store.dispatch(getMasterList(store));
  }

  clearErrors() {
    this.error = false;
    this.errorTitle = '';
    this.errorMessage = '';
  }

  List<String> get assignToList {
    List<String> arr = [];
    arr = this.persons.map((e) => e.assignedTo.toLowerCase() ).toList();
    List<String> result = LinkedHashSet<String>.from(arr).toList();
    result.sort();
    return result;
  }

  Person findPerson(facebookName) {
    return this.persons.firstWhere((p) {
      if (p != null && p.facebookName != null && facebookName != null) {
        return facebookName.toLowerCase() == p.facebookName.toLowerCase();
      }
      return false;
    });
  }
  
  List<Person> findPersonsAssignedTo(String assignedTo) {
    return this.persons.where((p) {
      if (p != null && p.assignedTo != null && assignedTo != null) {
        return assignedTo.toLowerCase() == p.assignedTo.toLowerCase();
      }
      return false;
    }).toList();
  }

  List<Person> findPersonsFBStartsWith(String startswith) {
    return this.persons.where((p) {
      if (p != null && p.facebookName != null && startswith != null) {
        return p.facebookName.toLowerCase().startsWith(startswith.toLowerCase());
      }
      return false;
    }).toList();
  }

  List<Person> findPersonsFBContains(String contains) {
    return this.persons.where((p) {
      if (p != null && p.facebookName != null && contains != null) {
        return p.facebookName.toLowerCase().contains(contains.toLowerCase());
      }
      return false;
    }).toList();
  }


} // DataController class




















