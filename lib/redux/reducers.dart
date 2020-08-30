
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';

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
  }

  return newState;

}