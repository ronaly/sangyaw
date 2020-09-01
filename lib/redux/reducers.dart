
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:sangyaw_app/redux/actions.dart';
//
//
//AppState reducer(AppState state, action) {
//
//  AppState app = AppState(
//    workbooks: workbookReducer(state.workbooks, action),
//    masterList: masterListReducer(state.masterList, action),
//    loading: loadingReducer(state.loading, action)
//  );
//  app.currentWorkbook = currentWorkbookReducer(state.currentWorkbook, action);
//
//  return app;
//}
//
//final workbookReducer = TypedReducer<List<String>, Workbooks>(_setWorkbookReducer);
//List<String> _setWorkbookReducer(List<String> state, Workbooks action) {
//  return action.payload;
//}
//
//final currentWorkbookReducer = TypedReducer<String, CurrentWorkbook>(_setCurrentWorkbookReducer);
//String _setCurrentWorkbookReducer(String state, CurrentWorkbook action) {
//  return action.payload;
//}
//final masterListReducer = TypedReducer<List<Person>, MasterList>(_setMasterListReducerReducer);
//List<Person> _setMasterListReducerReducer(List<Person> state, MasterList action) {
//  return action.payload;
//}
//
//final loadingReducer = TypedReducer<bool, Loading>(_setLoadingReducer);
//bool _setLoadingReducer(bool state, Loading action) {
//  return action.payload;
//}

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);
  if (action is Workbooks) {
    newState.workbooks = action.payload;
  } else if (action is CurrentWorkbook) {
    newState.currentWorkbook = action.payload;
  } else if (action is MasterList) {
    newState.masterList = action.payload;
  } else if (action is Loading) {
    newState.loading = action.payload;
  } else if (action is CurrentPerson) {
    newState.currentPerson = action.payload;
  } else if (action is NewPerson) {
    newState.newPerson = action.payload;
  } else if (action is CurrentAssigned) {
    newState.currentAssigned = action.payload;
  } else {
    print('Action is string');
    return prevState;
  }

  return newState;

}
