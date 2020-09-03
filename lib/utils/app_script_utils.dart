import 'dart:io' as Io;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sangyaw_app/config/config.dart';
import 'dart:convert';


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





      curl -L \
      -F 'action=uploadImage' \
      -F 'parentDirId=1EguChx_Tma_4zwbOA-RCuxCuS-xcda0o' \
      -F 'imageDirName=IMG_PamutanDirectory' \
      -F 'filename=Laica Mae Nano' \
      -F 'imageformat=jpeg' \
      -F "file=`base64 1.jpeg`" \
      'https://script.google.com/macros/s/AKfycbxMqHh-lcYmNinrydajF-oKDiHREcg1313jbi6JsfDVliXSNiA/exec'



      curl -L \
      -F 'action=uploadImage' \
      -F 'parentDirId=1EguChx_Tma_4zwbOA-RCuxCuS-xcda0o' \
      -F 'imageDirName=IMG_PamutanDirectory' \
      -F 'filename=Laica Mae Nano' \
      -F 'imageformat=jpeg' \
      -F "file=`base64 1.jpg`" \
      'https://script.google.com/macros/s/AKfycbxMqHh-lcYmNinrydajF-oKDiHREcg1313jbi6JsfDVliXSNiA/exec'

   */


  static dynamic imageUpload(String parentDirId, String imageDirName, Io.File file, String faceBookName) async{
    //create multipart request for POST or PATCH method
    var format = 'jpeg';
    final bytes = await file.readAsBytes();
    String img64 = base64Encode(bytes);

    print('Uploading File: ${file}');
    print('parentDirId: ${parentDirId}');
    print('imageDirName: ${imageDirName}');
    print('faceBookName: ${faceBookName}');
    print('format: ${format}');
    Dio dio = Dio();

    dynamic formData = FormData.fromMap({
      'action': 'uploadImage',
      'parentDirId': parentDirId,
      'imageDirName': imageDirName,
      'imageformat': format,
      'filename': faceBookName,
      "file": img64,
    });
    dynamic res = await dio.post(APP_SCRIPT_URL,
        options: Options(
            followRedirects: true,
            validateStatus: (status) { return status < 500; },
        ),
        data: formData,
        onSendProgress: (int sent, int total) {
          print("$sent $total");
        },
    );
    print('HTTP response status code: ${res.statusCode}');
    print('HTTP response status message: ${res.statusMessage}');
    print('HTTP Redirect URL: ${res.redirects}');
    print('HTTP Redirect Location: ${res.headers['location']}');
    if (res.statusCode == 302) {
      String url = res.headers['location'].first;
      res = await dio.get(url);
    }

    return {
      'completed': res.data['completed'],
      'imageId': res.data['imageId'],
      'imageName': res.data['imageName'],
    };
  }
}