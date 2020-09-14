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
      case 'savePerson':
        return savePerson(params);
      case 'uploadImage':
        return uploadImage(params);
      case 'listImages':
        return listImages(params);
      case 'assignPersons':
        return assignPersons(params);
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

function rowToPerson(row, id) {

    var person = {};
    person['id'] = id;
    person['facebookName'] = row[0];
    person['gender'] = row[1];
    person['address'] = row[2];
    person['ageGroup'] = row[3];
    person['messengerStatus'] = row[4];
    person['profileImage'] = row[5];
    person['referenceDetails'] = row[6];
    person['assignedTo'] = row[7];
    person['preachedBy'] = row[8];
    person['dateContacted'] = row[9];
    person['remarks'] = row[10];
    person['progressStatus'] = row[11];
    return person;

}

function personToRow(person) {
    var row = [];
    row[0] = person['facebookName'];
    row[1] = person['gender'];
    row[2] = person['address'];
    row[3] = person['ageGroup'];
    row[4] = person['messengerStatus'];
    row[5] = person['profileImage'];
    row[6] = person['referenceDetails'];
    row[7] = person['assignedTo'];
    row[8] = person['preachedBy'];
    row[9] = person['dateContacted'];
    row[10] = person['remarks'];
    row[11] = person['progressStatus'];
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

    if(file.getName() != 'releases') {
      data[i] = row;
      i++;
    }


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

      var img = getOrCreateImageFolder(folder, file);
      row['imageFolderExists'] = img['imageFolderExists'];
      row['imageFolderCreated'] = img['imageFolderCreated'];
      row['imageFolderId'] = img['imageFolderId'];
      row['imageFolderName'] = img['imageFolderName'];



      data[i] = row;
      i++;
    }

  }
  return data;
}

function getOrCreateImageFolder(folder, file) {
  var folderName = 'IMG_' + file.getName();

//  try {
//    var imageFolder = folder.getFoldersByName(folderName);
//    row['imageFolderId'] = imageFolder.getId();
//    row['imageFolderName'] = imageFolder.getName();
//  } catch (err) {
//    var imageFolder = folder.createFolder(folderName);
//    row['imageFolderId'] = imageFolder.getId();
//    row['imageFolderName'] = imageFolder.getName();
//  }
  var data = {};
  if(isFolderExists(folder, folderName)) {
    data['imageFolderExists'] = true;
    data['imageFolderCreated'] = false;

    data['imageFolderId'] = getFolderId(folder, folderName);
    data['imageFolderName'] = folderName;
  } else {
    data['imageFolderExists'] = false;
    data['imageFolderCreated'] = true;

    var imageFolder = folder.createFolder(folderName);
    imageFolder.setSharing(DriveApp.Access.ANYONE, DriveApp.Permission.VIEW);
    data['imageFolderId'] = imageFolder.getId();
    data['imageFolderName'] = imageFolder.getName();

  }

  return data;
}

function getFolderId(folder, folderName) {
  var folders = folder.getFolders();
  while(folders.hasNext()) {
    var f = folders.next();
    if(f.getName() == folderName) {
      return f.getId();
    }
  }
  return null;
}

function isFolderExists(folder, folderName) {
  var folders = folder.getFolders();
  while(folders.hasNext()) {
    var f = folders.next();
    if(f.getName() == folderName) {
      return true;
    }
  }
  return false;
}

function deletePerson(params) {
  return sendNotYetImplemented();
}

function insertPerson(params) {
  var sheet = getSheet(params);
  if(sheet == null) {
    throw new Error('Sangyaw API insertPerson Error cannot open sheet');
  }

  var person = params['parameter'];
  var rowData = personToRow(person);
  sheet.appendRow(rowData);
  var row = sheet.getLastRow();

  var p = rowToPerson(rowData, row);
  p['completed'] = true;
  p['row'] = row;

  return sendData(p);

}

function updatePerson(params) {
  var sheet = getSheet(params);
  if(sheet == null) {
    throw new Error('Sangyaw API updatePerson Error cannot open sheet');
  }
  var person = params['parameter'];
  var row = person['id'].toString();

  var rowData = personToRow(person);

  sheet.getRange('a'+ row).setValue(rowData[0].toString());
  sheet.getRange('b'+ row).setValue(rowData[1].toString());
  sheet.getRange('c'+ row).setValue(rowData[2].toString());
  sheet.getRange('d'+row).setValue(rowData[3].toString());
  sheet.getRange('e'+row).setValue(rowData[4].toString());
  sheet.getRange('f'+row).setValue(rowData[5].toString());
  sheet.getRange('g'+row).setValue(rowData[6].toString());
  sheet.getRange('h'+row).setValue(rowData[7].toString());
  sheet.getRange('i'+row).setValue(rowData[8].toString());
  sheet.getRange('j'+row).setValue(rowData[9].toString());
  sheet.getRange('k'+row).setValue(rowData[10].toString());
  sheet.getRange('l'+row).setValue(rowData[11].toString());
  var p = rowToPerson(rowData, row);
  p['completed'] = true;
  p['row'] = row;
  p['id'] = row;
  return sendData(p);

}

function savePerson(params) {

  var person = params['parameter'];

  if(person['facebookName'] == null || person['facebookName'].length == 0) {
    throw new Error('Facebook Name is Required to save Person Details');
  }

  var sheet = getSheet(params);
  if(sheet == null) {
    throw new Error('Sangyaw API updatePerson Error cannot open sheet');
  }
  var personId = person['id'];

  if(personId == null) {
    return insertPerson(params);
  }  else {
    return updatePerson(params);
  }

}

function findPersonRow(sheet, fbName) {
  var row = sheet.getLastRow();
  //(start row, start column, number of rows, number of columns
  var range = sheet.getRange(1, 1, rows, 1);
  var values = range.getValues();

  var searchResult = values.indexOf(fbName); //Row Index - 2

  if(searchResult != -1)
  {
    return searchResult + 2;
  }
  return -1;
}

function listPersons(params) {
  var sheet = getSheet(params);
  if(sheet == null) {
    throw new Error('Sangyaw API listPersons Error cannot open sheet');
  }
  var values = sheet.getSheetByName('MasterList').getDataRange().getValues();

  var data = [];

  for (var i = 1; i < values.length; i++) {

    var row = values[i];
    var person = rowToPerson(row, i + 1);
    data.push(person);

  } //end for loop

  //Return result
  return sendData(data);

}

function assignPersons(e) {
  
  var sheet = getSheet(params);
  if(sheet == null) {
    throw new Error('Sangyaw API updatePerson Error cannot open sheet');
  }

  var args = params['parameter'];
  if(!args || !args['assignTo'] || !args['ids']) {
    throw new Error('Sangyaw API assignPersons Error missing required parameters');
  }

  var data = {};

  var assignTo = args['assignTo'];
  var ids = args['ids'].split(',');
  for(var i = 0; i < ids.length; i++) {
    var row = ids[i];
    // column h is assign to
    sheet.getRange('h'+ row).setValue(assignTo);
    data[row] = { 'assignedTo': assignTo, success: true, id: row};
  }
  return sendData(data);
}


function uploadImage(e) {
  if (!e.parameters.filename || !e.parameters.file || !e.parameters.imageformat  || !e.parameters.parentDirId  || !e.parameters.imageDirName) {
    throw new Error('Sangyaw API missing parameters for Image upload');
  } else {
    var imgf = e.parameters.imageformat[0].toUpperCase();
    var mime =
        (imgf == 'BMP')  ? MimeType.BMP
      : (imgf == 'GIF')  ? MimeType.GIF
      : (imgf == 'JPEG') ? MimeType.JPEG
      : (imgf == 'PNG')  ? MimeType.PNG
      : (imgf == 'SVG')  ? MimeType.SVG
      : false;
    if (mime) {
      try {
        var data = Utilities.base64Decode(e.parameters.file, Utilities.Charset.UTF_8);
        var blob = Utilities.newBlob(data, mime, e.parameters.filename);
        var f = getImageFolder(e.parameters.parentDirId, e.parameters.imageDirName).createFile(blob);
        var data = { 'completed': true, 'imageId': f.getId(), 'imageName': f.getName() };
        return sendData(data);
      } catch(err) {
        return sendError('SangyawAPIError', err.message);
      }
    } else {
      throw new Error('Sangyaw API Error, Bad image format');
    }
  }
}

function getImageFolder(parentDirId, imgDir) {
  var folder = getFolder(parentDirId);
  if(!folder) {
    throw new Error('Sangyaw API Error, Image parent folder not found');
  }
  var items = folder.getFoldersByName(imgDir);
  while(items.hasNext()) {
    var item = items.next();
    if(item.getName() == imgDir) {
      return item;
    }
  }
  throw new Error('Sangyaw API Error, Image folder not found');
}


function listImages(params) {
//  if (!params.parameters.imageFolderId) {
//    throw new Error('Sangyaw API missing parameters for imageFolderId');
//  }

//  var imgDir = DriveApp.getFolderById(params.parameters.imageFolderId).getFolders();
  var folder = getFolder();
  var imgDir = getImageFolder('1EguChx_Tma_4zwbOA-RCuxCuS-xcda0o', 'IMG_StagingDirectory').getFiles();


  var data = [];
  var i = 0;
  while(imgDir.hasNext()) {
    var row = {};
    var img = imgDir.next();
    row['name'] = img.getName();
    row['id'] = img.getId();
    row['url'] = img.getUrl();
    data[i] = row;
    i++;
  }

  return sendData(data);

}