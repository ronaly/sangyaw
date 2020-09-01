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

  AppState({@required this.workbooks, @required this.masterList, @required this.loading });
  AppState.fromAppState(AppState another) {
    workbooks = another.workbooks;
    currentWorkbook = another.currentWorkbook;
    masterList = another.masterList;
    loading = another.loading;
    currentPerson = another.currentPerson;
    newPerson = another.newPerson;
    currentAssigned = another.currentAssigned;
  }
  List<String> get viewWorkbooks => workbooks;
  String get viewCurrentWorkbook => currentWorkbook;
  List<Person> get viewMasterList => masterList;
  bool get viewLoading => loading;
  Person get viewCurrentPerson => currentPerson;
  Person get viewNewPerson => newPerson;
  String get viewCurrentAssigned => currentAssigned;

  dynamic toJson() => {
    'workbooks': workbooks,
    'currentWorkbook': currentWorkbook,
    'masterList': masterList.hashCode,
    'loading': loading,
    'currentPerson': currentPerson.hashCode,
    'newPerson': newPerson.hashCode,
    'currentAssigned': currentAssigned,
  };

  @override
  String toString() {
    return 'AppState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }

}