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
      case 'uploadImage':
        return uploadImage(params);
      case 'listImages':
        return listImages(params);
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