function doGet(request) {

  // Open Google Sheet using ID
  var params = request;

  if (!(params && params['parameter'] && params['parameter']['sheetId'])) {
    // sheet ID not provided, should return error
    var data = {'error': true, 'title': 'Missing sheetId parameter', 'message': 'sheetID is required by sangyaw API' };
    return ContentService
              .createTextOutput(JSON.stringify(data))
              .setMimeType(ContentService.MimeType.JSON);
  }

  var sheetId = params['parameter']['sheetId'];

  var sheet = null;
  try {
    sheet = SpreadsheetApp.openById(sheetId);
  } catch (err) {
    var data = {'error': true, 'title': 'SheetId not found', 'message': err.message };
    return ContentService
              .createTextOutput(JSON.stringify(data))
              .setMimeType(ContentService.MimeType.JSON);
  }

  var action = params['parameter']['action'];

  switch(action) {
    case 'deletePerson':
      return deletePerson(sheet, params)
    case 'listPersons':
      return listPersons(sheet, params);
    default:
      return sendUnknownAction();
  }


  // Get all the values from Bucawe Sheet




}  //end function

function doPost(e) {

  // Open Google Sheet using ID
  var params = request;

  if (!(params && params['parameter'] && params['parameter']['sheetId'])) {
    // sheet ID not provided, should return error
    var data = {'error': true, 'title': 'Missing sheetId parameter', 'message': 'sheetID is required by sangyaw API' };
    return ContentService
              .createTextOutput(JSON.stringify(data))
              .setMimeType(ContentService.MimeType.JSON);
  }

  var sheetId = params['parameter']['sheetId'];

  var sheet = null;
  try {
    sheet = SpreadsheetApp.openById(sheetId);
  } catch (err) {
    var data = {'error': true, 'title': 'SheetId not found', 'message': err.message };
    return ContentService
              .createTextOutput(JSON.stringify(data))
              .setMimeType(ContentService.MimeType.JSON);
  }

  var action = params['parameter']['action'];

  switch(action) {
    case 'insertPerson':
      return insertPerson(sheet, params)
    case 'updatePerson':
      return updatePerson(sheet, params);
    default:
      return sendUnknownAction();
  }


}

function sendData(data) {
   return ContentService
          .createTextOutput(JSON.stringify(data))
          .setMimeType(ContentService.MimeType.JSON);
}

function sendUnknownAction() {
  var data = {'error': true, 'title': 'Sangyaw API Error, unknown action', 'message': 'Sangyaw API Error, unknown action'};
  return sendData(data);
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

function deletePerson(sheet, params) {
  return sendNotYetImplemented();
}

function insertPerson(sheet, params) {
  return sendNotYetImplemented();
}

function updatePerson(sheet, params) {
  return sendNotYetImplemented();
}


function listPersons(sheet, params) {
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

