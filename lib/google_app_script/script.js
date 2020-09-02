function getSheet(params) {

  if (!(params && params['parameter'] && params['parameter']['sheetId'])) {
    // sheet ID not provided, should return error

    throw new Error('parameter sheetId is required by sangyaw API');
  }

  var sheetId = params['parameter']['sheetId'];

  var sheet = null;
  try {
    sheet = SpreadsheetApp.openById(sheetId);
  } catch (err) {
    throw new Error('sheetId not found, ' + err.message);
  }
  return sheet;

}



function routeActions(params) {
  try {

    var action = params['parameter']['action'];

    switch(action) {
      case 'settings':
        return settings();
      // case 'listFolders':
      //  return listFolders();
      case 'deletePerson':
        return deletePerson(params)
        case 'listPersons':
        return listPersons(params);
      // case 'listSheets':
      //  return listSheets(params);
      case 'insertPerson':
        return insertPerson(params)
      case 'updatePerson':
        return updatePerson(params);
      default:
        return sendUnknownAction();
    }

  } catch (err) {
    return sendError('Sangyaw App API Error', err.message);

  }
}

function doGet(params) {
  return routeActions(params);
}  //end function

function doPost(params) {
  return routeActions(params);
}

function sendData(data) {
   return ContentService
          .createTextOutput(JSON.stringify(data))
          .setMimeType(ContentService.MimeType.JSON);
}

function sendError(title, message) {
  var data = {'error': true, 'title': title, 'message': message };
  return sendData(data);
}

function sendUnknownAction() {
  return sendError('Sangyaw API Error, unknown action', 'Sangyaw API Error, unknown action');
}

function rowToPerson(row) {

    var person = {};
    person['Facebook Name'] = row[0];
    person['Gender'] = row[1];
    person['Address'] = row[2];
    person['Age Group'] = row[3];
    person['Messenger Status'] = row[4];
    person['Profile Image'] = row[5];
    person['Reference Details'] = row[6];
    person['Assigned To'] = row[7];
    person['Preached By'] = row[8];
    person['Date Contacted'] = row[9];
    person['Remarks'] = row[10];
    person['Progress Status'] = row[11];
    return person;

}

function personToRow(person) {
    var row = [];
    row[0] = person['Facebook Name'];
    row[1] = person['Gender'];
    row[2] = person['Address'];
    row[3] = person['Age Group'];
    row[4] = person['Messenger Status'];
    row[5] = person['Profile Image'];
    row[6] = person['Reference Details'];
    row[7] = person['Assigned To'];
    row[8] = person['Preached By'];
    row[9] = person['Date Contacted'];
    row[10] = person['Remarks'];
    row[11] = person['Progress Status'];
    return row;
}



function sendNotYetImplemented() {
  var data = {'error': true, 'title': 'Sangyaw API Error, action is not yet implemented', 'message': 'Sangyaw API Error, action is not yet implemented'};
  return sendData(data);
}

function settings() {
  var data = listFolders();
  return sendData(data);
}

function listFolders() {
  var folder = DriveApp.getRootFolder();
  var contents = folder.getFolders();
  var data = [];
  var i = 0;
  while(contents.hasNext()) {
    var file = contents.next();

    var row = {
      'folderId': file.getId(),
      'folderName' : file.getName(),
      'sheets' : listSheets(file.getId()),
    };

    data[i] = row;
    i++;


  }
  return data;


}

function getFolder(folderId) {
  var folder = null;
  try {
    folder = DriveApp.getFolderById(folderId);
  } catch (err) {
    throw new Error('folderId not found, ' + err.message);
  }
  return folder;

}

function listSheets(folderId) {
  // var folder = DriveApp.getFolderById('1EguChx_Tma_4zwbOA-RCuxCuS-xcda0o');
  var folder = getFolder(folderId)
  var contents = folder.getFiles();
  var data = [];
  var i = 0;
  while(contents.hasNext()) {
    var file = contents.next();
      if (file.getMimeType() == 'application/vnd.google-apps.spreadsheet') {
        var row = {
        'fileId': file.getId(),
        'fileName' : file.getName()
      };

      data[i] = row;
      i++;
    }

  }
  return data;
}

function deletePerson(params) {
  return sendNotYetImplemented();
}

function insertPerson(params) {
  return sendNotYetImplemented();
}

function updatePerson(params) {
  return sendNotYetImplemented();
}


function listPersons(params) {
  var sheet = getSheet(params);
  if(sheet == null) {
    return;
  }
  var values = sheet.getSheetByName('MasterList').getDataRange().getValues();

  var data = [];

  for (var i = 1; i < values.length; i++) {

    var row = values[i];
    var person = rowToPerson(row);
    data.push(person);

  } //end for loop

  //Return result
  return sendData(data);

}

