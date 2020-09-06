import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/config/config.dart';
import 'package:sangyaw_app/model/person.dart';



@immutable
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

  AppState(){
    this.settings = [];
    this.workbooks = []; // SANGYAW_SHEET_IDS.keys.toList(); // ['Pamutan', 'Tuong', 'Error Test'];
    this.masterList = new SplayTreeMap<int, Person>();
    this.loading = true;
    this.appError = false;
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

  List<String> get viewAssignToList {
    List<String> raw = this.masterList.values.map((e) => '${e.assignedTo}' ).toList();
    return this.getUnique(raw);
  }

  List<String> get viewAddressList {
    List<String> raw = this.masterList.values.map((e) => '${e.address}' ).toList();
    return this.getUnique(raw);
  }

  List<String> get viewFbNameList {
    List<String> raw = this.masterList.values.map((e) => '${e.facebookName}' ).toList();
    return this.getUnique(raw);
  }


  List<String> get viewLowerFbNameList {
    List<String> raw = this.masterList.values.map((e) => '${e.facebookName.toLowerCase()}' ).toList();
    return this.getUnique(raw);
  }

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
  };

  @override
  String toString() {
    return 'AppState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }

}