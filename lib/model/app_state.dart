import 'dart:collection';
import 'dart:convert';

import 'package:sangyaw_app/model/person.dart';



// ignore: must_be_immutable
class AppState {
  List<dynamic> settings = [];
  List<String> workbooks;
  String currentWorkbook;
  SplayTreeMap<int, Person> masterList;
  bool loading;

  Person currentPerson;
  Person newPerson;
  String currentAssigned;

  bool appError;
  String appErrorTitle;
  String appErrorMessage;

  String queryTerm;

  // indexes and aggregates
  List<String> assignToList;
  List<String> addressList;
  List<String> fbNameList;
  List<String> lowerFbNameList;
  SplayTreeMap<String, Person> fbNameIndex;
  SplayTreeMap<String, List<Person>> personsAssignedToIndex;
  SplayTreeMap<String, int> personsAssignedToCountIndex;
  SplayTreeMap<String, List<Person>> personsByTerritoryIndex;
  SplayTreeMap<String, int> personsByTerritoryCountIndex;



  AppState(){
    this.settings = [];
    this.workbooks = []; // SANGYAW_SHEET_IDS.keys.toList(); // ['Pamutan', 'Tuong', 'Error Test'];
    this.masterList = new SplayTreeMap<int, Person>();
    this.loading = true;
    this.appError = false;
    this.assignToList = [];
    this.addressList = [];
    this.fbNameList = [];
    this.lowerFbNameList = [];
    this.fbNameIndex = new SplayTreeMap<String, Person>();
    this.personsAssignedToIndex = new SplayTreeMap<String, List<Person>>();
    this.personsAssignedToCountIndex = new SplayTreeMap<String, int>();
    this.personsByTerritoryIndex = new SplayTreeMap<String, List<Person>>();
    this.personsByTerritoryCountIndex = new SplayTreeMap<String, int>();
//    {@required this.workbooks, @required this.masterList, @required this.loading, @required this.appError }
  }
  AppState.fromAppState(AppState another) {
    settings = another.settings;
    workbooks = another.workbooks;
    currentWorkbook = another.currentWorkbook;
    masterList = another.masterList;
    loading = another.loading;
    currentPerson = another.currentPerson;
    newPerson = another.newPerson;
    currentAssigned = another.currentAssigned;
    appError = another.appError;
    appErrorTitle = another.appErrorTitle;
    appErrorMessage = another.appErrorMessage;
    queryTerm = another.queryTerm;
    assignToList = another.assignToList;
    addressList = another.addressList;
    fbNameList = another.fbNameList;
    lowerFbNameList = another.lowerFbNameList;
    fbNameIndex = another.fbNameIndex;
    personsAssignedToIndex = another.personsAssignedToIndex;
    personsAssignedToCountIndex = another.personsAssignedToCountIndex;
    personsByTerritoryIndex = another.personsByTerritoryIndex;
    personsByTerritoryCountIndex = another.personsByTerritoryCountIndex;
  }
  dynamic get viewSettings => settings;
  List<String> get viewWorkbooks => workbooks;
  String get viewCurrentWorkbook => currentWorkbook;
  SplayTreeMap<int, Person> get viewMasterList => masterList;
  List<Person> get viewPersons => masterList.values.toList();
  int get viewTotalPersons => masterList.length;
  bool get viewLoading => loading;

  Person get viewCurrentPerson => currentPerson;
  Person get viewNewPerson => newPerson;
  String get viewCurrentAssigned => currentAssigned;

  bool get viewAppError => appError;
  String get viewAppErrorTitle => appErrorTitle;
  String get viewAppErrorMessage => appErrorMessage;

  String get viewQueryTerm => queryTerm;

  // indexes and aggregates
  List<String> get viewAssignToList => assignToList;
  List<String> get viewAddressList => addressList;
  List<String> get viewFbNameList => fbNameList;
  List<String> get viewLowerFbNameList => lowerFbNameList;
  SplayTreeMap<String, Person> get viewFbNameIndex => fbNameIndex;


  SplayTreeMap<String, List<Person>> get viewPersonsAssignedToIndex => personsAssignedToIndex;
  SplayTreeMap<String, int> get viewPersonsAssignedToCountIndex => personsAssignedToCountIndex;
  SplayTreeMap<String, List<Person>> get viewPersonsByTerritoryIndex => personsByTerritoryIndex;
  SplayTreeMap<String, int> get viewPersonsByTerritoryCountIndex => personsByTerritoryCountIndex;





  dynamic toJson() => {
    'settings': settings.hashCode,
    'workbooks': workbooks,
    'currentWorkbook': currentWorkbook,
    'masterList': masterList.hashCode,
    'loading': loading,
    'currentPerson': currentPerson.hashCode,
    'newPerson': newPerson.hashCode,
    'currentAssigned': currentAssigned,
    'appError': appError,
    'appErrorTitle': appErrorTitle,
    'appErrorMessage': appErrorMessage,
    'queryTerm': queryTerm,
    'assignToList': assignToList.hashCode,
    'addressList': addressList.hashCode,
    'fbNameList': fbNameList.hashCode,
    'lowerFbNameList': lowerFbNameList.hashCode,
    'fbNameIndex': fbNameIndex.hashCode,
    'personsAssignedToIndex': personsAssignedToIndex.hashCode,
    'personsAssignedToCountIndex': personsAssignedToCountIndex.hashCode,
    'personsByTerritoryIndex': personsByTerritoryIndex.hashCode,
    'personsByTerritoryCountIndex': personsByTerritoryCountIndex.hashCode,
  };

  @override
  String toString() {
    return 'AppState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }

}