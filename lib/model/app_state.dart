import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/config/config.dart';
import 'package:sangyaw_app/model/person.dart';



@immutable
class AppState {
  List<dynamic> settings = [];
  List<String> workbooks;
  String currentWorkbook;
  List<Person> masterList;
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
    this.masterList = [];
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
  List<Person> get viewMasterList => masterList;
  bool get viewLoading => loading;

  Person get viewCurrentPerson => currentPerson;
  Person get viewNewPerson => newPerson;
  String get viewCurrentAssigned => currentAssigned;

  bool get viewAppError => appError;
  String get viewAppErrorTitle => appErrorTitle;
  String get viewAppErrorMessage => appErrorMessage;

  String get viewQueryTerm => queryTerm;

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