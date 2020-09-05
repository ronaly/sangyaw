import 'package:redux/redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:sangyaw_app/utils/app_script_utils.dart';
import '../model/person.dart';
import "dart:collection";

class SangyawSettings {
  String folderId;
  String folderName;
  String sheetId;
  String sheetName;
  String imageFolderId;
  String imageFolderName;
  SangyawSettings(this.folderId, this.folderName, this.sheetId, this.sheetName, this.imageFolderId, this.imageFolderName);
}

class DataController {
  Store<AppState> store;

  DataController(Store<AppState> store) {
    this.store = store;
  }

  SangyawSettings get currentSettings {
    dynamic settings = AppScriptUtils.getSangyawSettingstMap(store);
    dynamic sheet = (settings['sheets'] as List).firstWhere((e) => e['fileName'] == this.currentDirectory);
    return new SangyawSettings(
        settings['folderId'],
        settings['folderName'],
        sheet['fileId'],
        sheet['fileName'],
        sheet['imageFolderId'],
        sheet['imageFolderName']
    );
  }

  SplayTreeMap<int, Person> get masterList =>  store.state.viewMasterList;
  List<Person> get persons =>  store.state.viewMasterList.values.toList();
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

  String get queryTerm => store.state.queryTerm;

  set currentPerson(Person person) {
    store.dispatch(CurrentPerson(person.clone()));
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

  set queryTerm(String queryTerm) {
    store.dispatch(QueryTerm(queryTerm));
  }

  cancelCurrentPersonChanges() {
    this.currentPerson = this.persons[this.currentPerson.id];
  }

  updatePersonToLocalList(Person p) {
    if(this.persons[p.id] != null) {
      this.persons[p.id].mutate(p);
    } else {
      this.persons[p.id] = p.clone();
    }
//    store.dispatch(MasterList(this.persons));
  }

  Future<Person> savePerson(Person person) {
    String sheetId = AppScriptUtils.getGoogleSheetId(store);
    return AppScriptUtils.savePerson(sheetId, person).then((value){
      print('===========================');
      print('Save Person Success!!!!');
      print(value);
      updatePersonToLocalList(value);
      this.currentPerson = value;
      print('===========================');
      return value;
    });

  }

  reloadMasterList() {
    store.dispatch(getMasterList(store));
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

  List<String> reduceThisElement(List<String> arrHolder, List<String> tobeAdded) {
    List<String> lowered = arrHolder.map((e) => '$e'.toLowerCase()).toList();
    List<String> newVal = arrHolder.map((e) => e).toList();
    if(!lowered.contains('${tobeAdded[0]}'.toLowerCase())) {
      // add its not yet in the list
      newVal.add(tobeAdded[0]);
    }
    return newVal;
  }

  List<String> getUnique(List<String> list) {
    if (list == null || list.length == 0) {
      return [];
    }
    List<List<String>> raw = list.map((e) => ['${e}'] ).toList();

    List<String> result = raw.reduce(this.reduceThisElement);
    result.sort();

    return result;

  }

  List<String> get assignToList {
    List<String> raw = this.persons.map((e) => '${e.assignedTo}' ).toList();
    return this.getUnique(raw);
  }

  List<String> get addressList {
    List<String> raw = this.persons.map((e) => '${e.address}' ).toList();
    return this.getUnique(raw);
  }

  List<String> get fbNameList {
    List<String> raw = this.persons.map((e) => '${e.facebookName}' ).toList();
    return this.getUnique(raw);
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

  List<Person> findPersonsByTerritory(String territory) {
    return this.persons.where((p) {
      if (p != null && p.address != null && territory != null) {
        return territory.toLowerCase() == p.address.toLowerCase();
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




















