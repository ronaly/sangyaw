import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sangyaw_app/config/config.dart';


class AppScriptUtils {

  /**
   *

      curl -L \
      -F 'action=uploadImage' \
      -F 'parentDirId=1EguChx_Tma_4zwbOA-RCuxCuS-xcda0o' \
      -F 'imageDirName=IMG_StagingDirectory' \
      -F 'filename=samplebird' \
      -F 'imageformat=jpeg' \
      -F "file=`base64 1.jpeg`" \
      'https://script.google.com/macros/s/AKfycbxMqHh-lcYmNinrydajF-oKDiHREcg1313jbi6JsfDVliXSNiA/exec'

   */


  static imageUpload(String parentDirId, String imageDirName, File file, String faceBookName) async{
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest('POST', Uri.parse(APP_SCRIPT_URL));
    //add text fields
    request.fields['action'] = 'uploadImage';
    request.fields['parentDirId'] = parentDirId;
    request.fields['imageDirName'] = imageDirName;
    request.fields['filename'] = faceBookName;

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath('file', file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }
}