import 'package:redux/redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:sangyaw_app/utils/app_script_utils.dart';
import 'package:sangyaw_app/utils/globals.dart';
import '../model/person.dart';
import "dart:collection";

class SangyawSettings {
  String folderId;
  String folderName;
  String sheetId;
  String sheetName;
  String imageFolderId;
  String imageFolderName;
  SangyawSettings(this.folderId, this.folderName, this.sheetId, this.sheetName,
      this.imageFolderId, this.imageFolderName);
}

class DataController {
  Store<AppState> store;

  DataController(Store<AppState> store) {
    this.store = store;
  }

  Globals get globals {
    return this.store.state.viewGlobals;
  }

  SangyawSettings get currentSettings {
    dynamic settings = AppScriptUtils.getSangyawSettingstMap(store);
    if (settings == null) {
      print('Settings is null');
      // return SangyawSettings('', '', '', '', '', '');
      return null;
    }
    if (this.currentDirectory == null) {
      return new SangyawSettings(
          settings['folderId'], settings['folderName'], null, null, null, null);
    }
    dynamic sheet = (settings['sheets'] as List)
        .firstWhere((e) => e['fileName'] == this.currentDirectory);
    return new SangyawSettings(
        settings['folderId'],
        settings['folderName'],
        sheet['fileId'],
        sheet['fileName'],
        sheet['imageFolderId'],
        sheet['imageFolderName']);
  }

  String get currentFolderName => currentSettings?.folderName;
  String get currentFolderId => currentSettings?.folderId;

  SplayTreeMap<int, Person> get masterList => store.state.viewMasterList;
  List<Person> get persons => store.state.viewPersons;
  int get totalPersons => store.state.viewTotalPersons;

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
    this.currentPerson = this.masterList[this.currentPerson.id];
  }

  Future<Person> savePerson(Person person) {
    print('===========================');
    print('Saving Person Person!!!!');
    print(person);
    print('===========================');

    String sheetId = AppScriptUtils.getGoogleSheetId(store);
    return AppScriptUtils.savePerson(sheetId, person).then((value) {
      print('===========================');
      print('Save Person Success!!!!');
      print(value);
      if (person.id == null) {
        print('Adding Person to MasterList');
        store.dispatch(AddPersonToMasterList(value));
      } else {
        print('Updating Person to MasterList');
        store.dispatch(UpdatePersonToMasterList(value));
      }
      print('===========================');
      return value;
    });
  }

  Future<bool> assignPersons(String assignTo, List<int> ids) {
    print('===========================');
    print('Assigning IDs to $assignTo!!!!');
    print(ids);
    print('===========================');

    String sheetId = AppScriptUtils.getGoogleSheetId(store);
    return AppScriptUtils.assignPersons(sheetId, assignTo, ids).then((data) {
      store.dispatch(UpdateAssignments(assignTo, ids));
      return true;
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

  loadSettings() {
    store.dispatch(loadAPISettings(store));
    store.dispatch(CurrentWorkbook(null));
    // store.dispatch(getMasterList(store));
  }

  // Indexes and Aggregates
  List<String> get congregationList => store.state.congregationList;
  List<String> get assignToList => store.state.viewAssignToList;
  List<String> get addressList => store.state.viewAddressList;
  List<String> get fbNameList => store.state.viewFbNameList;
  List<String> get lowerCasedFbNameList => store.state.viewLowerFbNameList;
  SplayTreeMap<String, Person> get fbNameIndex => store.state.viewFbNameIndex;
  SplayTreeMap<String, List<Person>> get personsAssignedToIndex =>
      store.state.viewPersonsAssignedToIndex;
  SplayTreeMap<String, int> get personsAssignedToCountIndex =>
      store.state.viewPersonsAssignedToCountIndex;
  SplayTreeMap<String, List<Person>> get personsByTerritoryIndex =>
      store.state.viewPersonsByTerritoryIndex;
  SplayTreeMap<String, int> get personsByTerritoryCountIndex =>
      store.state.viewPersonsByTerritoryCountIndex;

  Person findPerson(facebookName) {
    return this.fbNameIndex[facebookName.toString()];
  }

  List<Person> findPersonsAssignedTo(String assignedTo) {
    List<Person> list = this.personsAssignedToIndex[assignedTo.toLowerCase()];
    if (list != null) {
      return list;
    }
    return [];
  }

  int countPersonsAssignedTo(String assignedTo) {
    int count = this.personsAssignedToCountIndex[assignedTo.toLowerCase()];
    if (count != null) {
      return count;
    }
    return 0;
  }

  List<Person> findPersonsByTerritory(String territory) {
    List<Person> list = this.personsByTerritoryIndex[territory.toLowerCase()];
    if (list != null) {
      return list;
    }
    return [];
  }

  int countPersonsByTerritory(String territory) {
    int count = this.personsByTerritoryCountIndex[territory.toLowerCase()];
    if (count != null) {
      return count;
    }
    return 0;
  }

  List<Person> findPersonsFBStartsWith(String startswith) {
    return this.persons.where((p) {
      if (p != null && p.facebookName != null && startswith != null) {
        return p.facebookName
            .toLowerCase()
            .startsWith(startswith.toLowerCase());
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
