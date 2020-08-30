import 'package:flutter/material.dart';
import 'package:sangyaw_app/model/person.dart';

class AppState {
  List<String> workbooks;
  String currentWorkbook;
  List<Person> masterList;
  bool loading;
  AppState({@required this.workbooks, @required this.masterList, bool loading = false});
  AppState.fromAppState(AppState another) {
    workbooks = another.workbooks;
    currentWorkbook = another.currentWorkbook;
    currentWorkbook = another.currentWorkbook;
    masterList = another.masterList;
    loading = another.loading;
  }
  List<String> get viewWorkbooks => workbooks;
  String get viewCurrentWorkbook => currentWorkbook;
  List<Person> get viewMasterList => masterList;
  bool get viewLoading => loading;

}