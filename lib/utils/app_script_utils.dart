import 'dart:io' as Io;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'dart:convert';

import 'package:sangyaw_app/model/person.dart';

const String APP_SCRIPT_URL = 'https://script.google.com/macros/s/AKfycbxMqHh-lcYmNinrydajF-oKDiHREcg1313jbi6JsfDVliXSNiA/exec';
const String SANGYAW_APP_SETTINGS_URL = '$APP_SCRIPT_URL?action=settings';
const String SANGYAW_MASTER_LIST_URL = '$APP_SCRIPT_URL?action=listPersons&sheetId=';

class AppScriptUtils {

// Google App Script Web URL.
//const String APP_SCRIPT_URL = 'https://script.google.com/macros/s/AKfycbwsKt8R9yIWp_vMpCxxDmZlhSBFMJp2T5MZmLp7vi_B760KfVM/exec';

  static String getSangyawAppFolderInstance() {
    // TODO: in the future make this one dynamic based on user settings
    return 'BucaweCong';
  }

  static String getGoogleSheetId(Store<AppState> store) {
    List settings = store.state.viewSettings;
    String current = store.state.viewCurrentWorkbook;
    return getSangyawSheetMap(store)[current];
  }

  static dynamic getSangyawSettingstMap(Store<AppState> store) {

    List settings = store.state.viewSettings;
    String instance = getSangyawAppFolderInstance();
    dynamic setting = settings.firstWhere((element) => element['folderName'] == instance);

    return setting;
  }

  static Map<String, String> getSangyawSheetMap(Store<AppState> store) {
    Map<String, String> map = {};

    List settings = store.state.viewSettings;
    String instance = getSangyawAppFolderInstance();
    dynamic setting = settings.firstWhere((element) => element['folderName'] == instance);
    if( setting['sheets'] != null) {
      (setting['sheets'] as List).forEach((e) {
        map[e['fileName']] = e['fileId'];
      });
    }
    return map;
  }

  static List<String> getGoogleSheetNames(Store<AppState> store) {
    return getSangyawSheetMap(store).keys.toList();
  }


  static Future<List<Person>> getMasterList(String sheetId) async {
    String url = '$SANGYAW_MASTER_LIST_URL$sheetId';
    print(url);
    http.Response response = await http.get(
      Uri.encodeFull(url),
    );

    List result = json.decode(response.body) as List;
    List<Person> persons = result.map((json){
      return Person.fromJson(json);
    }).toList();
    return persons;
  }

  static Future<List<dynamic>> getSettings() async {
    http.Response response = await http.get(
      Uri.encodeFull(SANGYAW_APP_SETTINGS_URL),
    );

    List result = json.decode(response.body) as List;
    List<dynamic> settings = result.map((json){
      List sheets = json['sheets'];
      return {
        'folderId': json['folderId'],
        'folderName': json['folderName'],
        'sheets' : sheets,
      };
    }).toList();

    return settings;
  }


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



/**
 *
 *
    curl sample for file upload

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