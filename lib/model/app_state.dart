import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';

const Map<String, String> SANGYAW_SHEET_IDS = {
  'Pamutan' : '1y-GqdmM20Byli_u-wVB1CbRzUDV0qPhdcb5fH5xowTU',
  'Tuong' : '1Dqt2yNeMH-KTORX36-evAfsl-ftXtNuML5r7ZSwD0fs',
};

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

  String queryTerm;

  AppState(){
    this.workbooks = SANGYAW_SHEET_IDS.keys.toList(); // ['Pamutan', 'Tuong', 'Error Test'];
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
    queryTerm = another.queryTerm;
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

  String get viewQueryTerm => queryTerm;

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
    'queryTerm': queryTerm,
  };

  @override
  String toString() {
    return 'AppState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }

}