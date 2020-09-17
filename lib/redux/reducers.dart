import 'dart:collection';

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

List<String> reduceThisElement(List<String> arrHolder, List<String> tobeAdded) {
  List<String> lowered = arrHolder.map((e) => '$e'.toLowerCase()).toList();
  List<String> newVal = arrHolder.map((e) => e).toList();
  if (!lowered.contains('${tobeAdded[0]}'.toLowerCase())) {
    // add its not yet in the list
    newVal.add(tobeAdded[0]);
  }
  return newVal;
}

List<String> getUnique(List<String> list) {
  if (list == null || list.length == 0) {
    return [];
  }
  List<List<String>> raw = list.map((e) => ['$e']).toList();

  List<String> result = raw.reduce(reduceThisElement);
  result.sort();

  return result;
}

List<String> getAssignToList(masterList) {
  List<String> raw =
      masterList.values.map<String>((e) => '${e.assignedTo}').toList();
  return getUnique(raw);
}

List<String> getAddressList(masterList) {
  List<String> raw = masterList.values
      .map<String>((e) => '${e.address}')
      .toList() as List<String>;
  return getUnique(raw);
}

List<String> getFbNameList(masterList) {
  List<String> raw = masterList.values
      .map<String>((e) => '${e.facebookName}')
      .toList() as List<String>;
  return getUnique(raw);
}

List<String> getLowerFbNameList(masterList) {
  List<String> raw = masterList.values
      .map<String>((e) => '${e.facebookName}'.toLowerCase())
      .toList() as List<String>;
  return getUnique(raw);
}

// indexes and aggregates
//List<String> assignToList;
//List<String> addressList;
//List<String> fbNameList;
//List<String> lowerFbNameList;
// set indexes and aggregates
createIndexesAndAggregates(AppState newState) {
  newState.assignToList = getAssignToList(newState.masterList);
  newState.addressList = getAddressList(newState.masterList);
  newState.fbNameList = getFbNameList(newState.masterList);
  newState.lowerFbNameList = getLowerFbNameList(newState.masterList);

  // add fbNameIndexVAlues
  createFbNameIndex(newState);

  // add personsAssignedToIndex
  createPersonsByAssignedToIndex(newState);
  // add personsByTerritoryIndex
  createPersonsByTerritoryIndex(newState);
}

void createFbNameIndex(AppState newState) {
  // add fbNameIndexVAlues
  newState.fbNameIndex = new SplayTreeMap<String, Person>();
  newState.masterList.forEach((key, value) {
    newState.fbNameIndex.addAll({
      value.facebookName.toLowerCase(): value,
    });
  });
}

void createPersonsByAssignedToIndex(AppState newState) {
  // add personsAssignedToIndex
  newState.personsAssignedToIndex = new SplayTreeMap<String, List<Person>>();
  newState.personsAssignedToCountIndex = new SplayTreeMap<String, int>();
  newState.assignToList.forEach((assignedTo) {
    List<Person> persons = newState.masterList.values.where((p) {
      if (p != null && p.assignedTo != null && assignedTo != null) {
        return assignedTo.toLowerCase() == p.assignedTo.toLowerCase();
      }
      return false;
    }).toList();

    newState.personsAssignedToIndex.addAll({
      assignedTo.toLowerCase(): persons,
    });

    newState.personsAssignedToCountIndex.addAll({
      assignedTo.toLowerCase(): persons.length,
    });
  });
}

void createPersonsByTerritoryIndex(AppState newState) {
  // add personsByTerritoryIndex
  newState.personsByTerritoryIndex = new SplayTreeMap<String, List<Person>>();
  newState.personsByTerritoryCountIndex = new SplayTreeMap<String, int>();
  newState.addressList.forEach((address) {
    List<Person> persons = newState.masterList.values.where((p) {
      if (p != null && p.address != null && address != null) {
        return address.toLowerCase() == p.address.toLowerCase();
      }
      return false;
    }).toList();

    newState.personsByTerritoryIndex.addAll({
      address.toLowerCase(): persons,
    });

    newState.personsByTerritoryCountIndex.addAll({
      address.toLowerCase(): persons.length,
    });
  });
}

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);
  if (action is Settings) {
    buildSettings(newState, action);
  } else if (action is Workbooks) {
    newState.workbooks = action.payload;
  } else if (action is CurrentWorkbook) {
    newState.currentWorkbook = action.payload;
  } else if (action is MasterList) {
    newState.masterList = action.payload;
    createIndexesAndAggregates(newState);
  } else if (action is Loading) {
    newState.loading = action.payload;
  } else if (action is CurrentPerson) {
    newState.currentPerson = action.payload;
  } else if (action is NewPerson) {
    newState.newPerson = action.payload;
  } else if (action is CurrentAssigned) {
    newState.currentAssigned = action.payload;
  } else if (action is AppError) {
    newState.appError = action.payload;
  } else if (action is AppErrorTitle) {
    newState.appErrorTitle = action.payload;
  } else if (action is AppErrorMessage) {
    newState.appErrorMessage = action.payload;
  } else if (action is ClearAppErrors) {
    newState.appError = false;
    newState.appErrorTitle = null;
    newState.appErrorMessage = null;
    newState.loading = false;
  } else if (action is CreateAppError) {
    newState.appError = true;
    newState.appErrorTitle = action.title;
    newState.appErrorMessage = action.message;
    newState.loading = false;
  } else if (action is QueryTerm) {
    newState.queryTerm = action.payload;
  } else if (action is UpdatePersonToMasterList) {
    newState.masterList[action.payload.id] = action.payload;
    newState.currentPerson = action.payload;
    createIndexesAndAggregates(newState);
  } else if (action is AddPersonToMasterList) {
    newState.masterList.addAll({action.payload.id: action.payload});
    newState.currentPerson = action.payload;
    createIndexesAndAggregates(newState);
  } else if (action is UpdateAssignments) {
    for (var i = 0; i < action.ids.length; i++) {
      int id = action.ids[i];
      newState.masterList[id].assignedTo = action.assignTo;
    }
    createIndexesAndAggregates(newState);
  }

  return newState;
}

// {folderId: 1EguChx_Tma_4zwbOA-RCuxCuS-xcda0o, folderName: BucaweCong, sheets: [{fileId: 11O-DdnPkUTfGmUsZ0jpPNE9GXHuGTFJQu7TKakr8IzE, fileName: StagingDirectory, imageFolderExists: true, imageFolderCreated: false, imageFolderId: 1FZokHLZsAiFaIY3-9JJtnQ5zUAVpPAMv, imageFolderName: IMG_StagingDirectory}, {fileId: 1Dqt2yNeMH-KTORX36-evAfsl-ftXtNuML5r7ZSwD0fs, fileName: ToongDirectory, imageFolderExists: true, imageFolderCreated: false, imageFolderId: 1h-RwrMe5ykXbGRIupi0ISQlvOl5TuzmE, imageFolderName: IMG_ToongDirectory}, {fileId: 1y-GqdmM20Byli_u-wVB1CbRzUDV0qPhdcb5fH5xowTU, fileName: PamutanDirectory, imageFolderExists: true, imageFolderCreated: false, imageFolderId: 1ziAGOyXCF-Y5gXkMRFgApvGHWuBAveCL, imageFolderName: IMG_PamutanDirectory}]}

void buildSettings(AppState newState, Settings action) {
  newState.settings = action.payload;
  if (newState.settings == null) {
    return;
  }
  // List<String> congregations = [];
  // newState.settings.forEach((setting) {
  //   congregations.add(setting['folderName']);
  // });
  // newState.congregationList = congregations;
}
