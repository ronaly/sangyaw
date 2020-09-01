import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';

@immutable
class AppState {
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

  AppState(){
    this.workbooks = ['Pamutan', 'Tuong'];
    this.masterList = [];
    this.loading = false;
    this.appError = false;
//    {@required this.workbooks, @required this.masterList, @required this.loading, @required this.appError }
  }
  AppState.fromAppState(AppState another) {
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
  }
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

  dynamic toJson() => {
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
  };

  @override
  String toString() {
    return 'AppState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }

}