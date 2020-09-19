import 'dart:io' as Io;
import 'package:date_time_format/date_time_format.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'dart:convert';

import 'package:sangyaw_app/model/person.dart';
import 'package:mime_type/mime_type.dart';
import 'package:simple_rsa/simple_rsa.dart';

const String APP_SCRIPT_URL =
    'https://script.google.com/macros/s/AKfycbxMqHh-lcYmNinrydajF-oKDiHREcg1313jbi6JsfDVliXSNiA/exec';
const String SANGYAW_APP_SETTINGS_URL = '$APP_SCRIPT_URL?action=settings';
const String SANGYAW_MASTER_LIST_URL =
    '$APP_SCRIPT_URL?action=listPersons&sheetId=';

typedef AppScriptUtilsUploadStatusFunc = void Function(int sent, int total);

class AppScriptUtils {
// Google App Script Web URL.
//const String APP_SCRIPT_URL = 'https://script.google.com/macros/s/AKfycbwsKt8R9yIWp_vMpCxxDmZlhSBFMJp2T5MZmLp7vi_B760KfVM/exec';

  static String getSangyawAppFolderInstance(Store<AppState> store) {
    if (store.state.globals.congregation != null) {
      return store.state.globals.congregation;
    }
    return null;
    // return 'BucaweCong';
  }

  static String getGoogleSheetId(Store<AppState> store) {
    String current = store.state.viewCurrentWorkbook;
    return getSangyawSheetMap(store)[current];
  }

  static dynamic getSangyawSettingstMap(Store<AppState> store) {
    List settings = store.state.viewSettings;
    String instance = getSangyawAppFolderInstance(store);
    if (instance == null) {
      return null;
    }
    dynamic setting =
        settings.firstWhere((element) => element['folderName'] == instance);

    return setting;
  }

  static Map<String, String> getSangyawSheetMap(Store<AppState> store) {
    Map<String, String> map = {};

    List settings = store.state.viewSettings;
    String instance = getSangyawAppFolderInstance(store);
    if (instance == null) {
      return null;
    }
    dynamic setting =
        settings.firstWhere((element) => element['folderName'] == instance);
    if (setting['sheets'] != null) {
      (setting['sheets'] as List).forEach((e) {
        map[e['fileName']] = e['fileId'];
      });
    }
    return map;
  }

  static List<String> getGoogleSheetNames(Store<AppState> store) {
    if (getSangyawSheetMap(store) == null) {
      return [];
    }
    return getSangyawSheetMap(store).keys.toList();
  }

  static Future<List<Person>> getMasterList(String sheetId) {
    String url = '$SANGYAW_MASTER_LIST_URL$sheetId';
    print(url);
    return http
        .get(
      Uri.encodeFull(url),
    )
        .then((http.Response response) {
      List result = json.decode(response.body) as List;
      List<Person> persons = result.map((json) {
        return Person.fromJson(json);
      }).toList();
      return persons;
    });
  }

  static Future<List<dynamic>> getSettings() {
    return http
        .get(
      Uri.encodeFull(SANGYAW_APP_SETTINGS_URL),
    )
        .then((http.Response response) {
      print('===========aaaaaaaa===========');
      print(response.body);
      print('==========aaaaaaaaaaa============');
      List result = json.decode(response.body) as List;
      List<dynamic> settings = result.map((json) {
        List sheets = json['sheets'];
        return {
          'folderId': json['folderId'],
          'folderName': json['folderName'],
          'sheets': sheets,
          'crypt': json['md5sha1'],
          'password': json['md5sha1'] != null ? decrypt(json['md5sha1']) : null,
        };
        // if (json['md5sha1'] != null) {
        //   return decrypt(json['md5sha1']).then((value) {
        //     print('======================');
        //     print('The decrypted value: $value');
        //     print('======================');
        //     return {
        //       'folderId': json['folderId'],
        //       'folderName': json['folderName'],
        //       'sheets': sheets,
        //       'md5sha1': '$value',
        //     };
        //   });
        // } else {
        //   return {
        //     'folderId': json['folderId'],
        //     'folderName': json['folderName'],
        //     'sheets': sheets,
        //     'md5sha1': null,
        //   };
        // }
      }).toList();
      return settings;
    });
  }

  static String decrypt(String str) {
    return utf8.decode(base64.decode(str));
    // const PRIVATE_KEY =
    //     "MIIEoQIBAAKCAQBuAGGBgg9nuf6D2c5AIHc8vZ6KoVwd0imeFVYbpMdgv4yYi5ob" +
    //         "tB/VYqLryLsucZLFeko+q1fi871ZzGjFtYXY9Hh1Q5e10E5hwN1Tx6nIlIztrh5S" +
    //         "9uV4uzAR47k2nng7hh6vuZ33kak2hY940RSLH5l9E5cKoUXuQNtrIKTS4kPZ5IOU" +
    //         "SxZ5xfWBXWoldhe+Nk7VIxxL97Tk0BjM0fJ38rBwv3++eAZxwZoLNmHx9wF92XKG" +
    //         "+26I+gVGKKagyToU/xEjIqlpuZ90zesYdjV+u0iQjowgbzt3ASOnvJSpJu/oJ6Xr" +
    //         "WR3egPoTSx+HyX1dKv9+q7uLl6pXqGVVNs+/AgMBAAECggEANG9qC1n8De3TLPa+" +
    //         "IkNXk1SwJlUUnAJ6ZCi3iyXZBH1Kf8zMATizk/wYvVxKHbF1zTyl94mls0GMmSmf" +
    //         "J9+Hlguy//LgdoJ9Wouc9TrP7BUjuIivW8zlRc+08lIjD64qkfU0238XldORXbP8" +
    //         "2BKSQF8nwz97WE3YD+JKtZ4x83PX7hqC9zabLFIwFIbmJ4boeXzj4zl8B7tjuAPq" +
    //         "R3JNxxKfvhpqPcGFE2Gd67KJrhcH5FIja4H/cNKjatKFcP6qNfCA7e+bua6bL0Cy" +
    //         "DzmmNSgz6rx6bthcJ65IKUVrJK6Y0sBcNQCAjqZDA0Bs/7ShGDL28REuCS1/udQz" +
    //         "XyB7gQKBgQCrgy2pvqLREaOjdds6s1gbkeEsYo7wYlF4vFPg4sLIYeAt+ed0kn4N" +
    //         "dSmtp4FXgGyNwg7WJEveKEW7IEAMQBSN0KthZU4sK9NEu2lW5ip9Mj0uzyUzU4lh" +
    //         "B+zwKzZCorip/LIiOocFWtz9jwGZPCKC8expUEbMuU1PzlxrytHJaQKBgQCkMEci" +
    //         "EHL0KF5mcZbQVeLaRuecQGI5JS4KcCRab24dGDt+EOKYchdzNdXdM8gCHNXb8RKY" +
    //         "NYnHbCjheXHxV9Jo1is/Qi9nND5sT54gjfrHMKTWAtWKAaX55qKG0CEyBB87WqJM" +
    //         "Ydn7i4Rf0rsRNa1lbxQ+btX14d0xol9313VC5wKBgERD6Rfn9dwrHivAjCq4GXiX" +
    //         "vr0w2V3adD0PEH+xIgAp3NXP4w0mBaALozQoOLYAOrTNqaQYPE5HT0Hk2zlFBClS" +
    //         "BfS1IsE4DFYOFiZtZDoClhGch1z/ge2p/ue0+1rYc5HNL4WqL/W0rcMKeYNpSP8/" +
    //         "lW5xckyn8Jq0M1sAFjIJAoGAQJvS0f/BDHz6MLvQCelSHGy8ZUscm7oatPbOB1xD" +
    //         "62UGvCPu1uhGfAqaPrJKqTIpoaPqmkSvE+9m4tsEUGErph9o4zqrJqRzT/HAmrTk" +
    //         "Ew/8PU7eMrFVW9I68GvkNCdVFukiZoY23fpXu9FT1YDW28xrHepFfb1EamynvqPl" +
    //         "O88CgYAvzzSt+d4FG03jwObhdZrmZxaJk0jkKu3JkxUmav9Zav3fDTX1hYxDNTLi" +
    //         "dazvUFfqN7wqSSPqajQmMoTySxmLI8gI4qC0QskB4lT1A8OfmjcDwbUzQGam5Kpz" +
    //         "ymmKJA9DgQpPgEIjHAnw2dUDR+wI/Loywb0AGLIbszseCOlc2Q==";

    // return decryptString(str, PRIVATE_KEY).then((value) {
    //   return value;
    // }).catchError((err) {
    //   print('===============================');
    //   print(err);
    //   print('===============================');
    //   return null;
    // });
  }

  static defaultUploadFunc(int sent, int total) {
    print("$sent $total");
  }

  static Future<Person> savePerson(String sheetId, Person person) {
    print('=======[Person] Data save to save ======');
    print(person);
    Map<String, dynamic> data = {};
    data['id'] = person.id;
    data['action'] = 'savePerson';
    data['sheetId'] = sheetId;
    data['facebookName'] = '${person.facebookName}';
    data['gender'] = '${person.gender}';
    data['address'] = '${person.address}';
    data['ageGroup'] = '${person.ageGroup}';
    data['messengerStatus'] = '${person.messengerStatus}';
    data['profileImage'] = '${person.profileImage}';
    data['referenceDetails'] = '${person.referenceDetails}';
    data['assignedTo'] = '${person.assignedTo}';
    data['preachedBy'] = '${person.preachedBy}';
    data['dateContacted'] = '${person.dateContacted}';
    data['remarks'] = '${person.remarks}';
    data['progressStatus'] = '${person.progressStatus}';

    print('=======[Person -> Data] Data save to save ======');
    print(data);

    dynamic options = Options(
      followRedirects: true,
      validateStatus: (status) {
        return status < 500;
      },
    );
    dynamic formData = FormData.fromMap(data);

    Dio dio = Dio();

    return dio
        .post(
      APP_SCRIPT_URL,
      options: options,
      data: formData,
    )
        .then((res) {
      if (res.statusCode == 302) {
        String url = res.headers['location'].first;
        return dio.get(url).then((res) {
          print('=======Response Data from save======');
          print(res.data);
          return new Person.fromJson(res.data);
        });
      }

      print('=======Response Data from save======');
      print(res.data);

      return new Person.fromJson(res.data);
    });
  }

  static String getImageFormat(Io.File file) {
    String mimeType = mime(file.path);
    print('File Mime type for:');
    print('File: $file');
    print('Mime: $mimeType');
    // supported formats
    // BMP, GIF, JPEG, PNG, SVG
    switch (mimeType) {
      case 'image/bmp':
        return 'BMP';
      case 'image/gif':
        return 'GIF';
      case 'image/jpeg':
        return 'JPEG';
      case 'image/png':
        return 'PNG';
      case 'image/svg+xml':
        return 'SVG';
      default:
        return null;
    }
  }

  static Future<dynamic> imageUpload(String parentDirId, String imageDirName,
      Io.File file, String faceBookName,
      [AppScriptUtilsUploadStatusFunc func]) {
    //create multipart request for POST or PATCH method
    var format = getImageFormat(file);
    if (format == null) {
      throw new Exception('Image format is not supported for $file');
    }

    final bytes = file.readAsBytesSync();
    String img64 = base64Encode(bytes);
    String name = DateTimeFormat.format(DateTime.now(),
        format: DateTimeFormats.commonLogFormat);
    if (faceBookName != null && faceBookName.length > 0) {
      name = faceBookName;
    }

    Dio dio = Dio();

    // set progress function
    AppScriptUtilsUploadStatusFunc progressFunction = func;
    if (func == null) {
      progressFunction = defaultUploadFunc;
    }

    dynamic options = Options(
      followRedirects: true,
      validateStatus: (status) {
        return status < 500;
      },
    );

    dynamic formData = FormData.fromMap({
      'action': 'uploadImage',
      'parentDirId': parentDirId,
      'imageDirName': imageDirName,
      'imageformat': format,
      'filename': name,
      "file": img64,
    });

    return dio
        .post(
      APP_SCRIPT_URL,
      options: options,
      data: formData,
      onSendProgress: progressFunction,
    )
        .then((res) {
      if (res.statusCode == 302) {
        String url = res.headers['location'].first;
        return dio.get(url).then((res) {
          print(res.data);
          return {
            'completed': res.data['completed'],
            'imageId': res.data['imageId'],
            'imageName': res.data['imageName'],
          };
        });
      }

      return {
        'completed': res.data['completed'],
        'imageId': res.data['imageId'],
        'imageName': res.data['imageName'],
      };
    });
  }

  static Future<Map<String, dynamic>> assignPersons(
      String sheetId, String assignTo, List<int> ids) {
    print('=======[Assign To:] $ids ======');
    Map<String, dynamic> data = {};
    data['action'] = 'assignPersons';
    data['sheetId'] = sheetId;
    data['assignTo'] = assignTo;
    data['ids'] = ids.join(',');

    print('=======[Person -> Data] Data save to save ======');
    print(data);

    dynamic options = Options(
      followRedirects: true,
      validateStatus: (status) {
        return status < 500;
      },
    );
    dynamic formData = FormData.fromMap(data);

    Dio dio = Dio();

    return dio
        .post(
      APP_SCRIPT_URL,
      options: options,
      data: formData,
    )
        .then((res) {
      if (res.statusCode == 302) {
        String url = res.headers['location'].first;
        return dio.get(url).then((res) {
          print('=======Response Data from save======');
          print(res.data);
          return res.data;
        });
      }

      print('=======Response Data from save======');
      print(res.data);

      return res.data;
    });
  }
}

/**
 *
 *
 *

    curl sample savePersons





    reset;

    curl -L \
    -F "action=savePerson" \
    -F "sheetId=11O-DdnPkUTfGmUsZ0jpPNE9GXHuGTFJQu7TKakr8IzE" \
    -F "id=2" \
    -F "facebookName=Adriana Sanchez" \
    -F "gender=Female" \
    -F "address=Akasya" \
    -F "ageGroup=" \
    -F "messengerStatus=Active" \
    -F "profileImage=Akasya_Images/Adriana Sanchez.Profile Image.073906.png" \
    -F "referenceDetails=classmate ni Kate" \
    -F "assignedTo=ann rowen" \
    -F "preachedBy=Aya" \
    -F "dateContacted=7/11/2020" \
    -F "remarks=seenzoned" \
    -F "progressStatus=" \
    "https://script.google.com/macros/s/AKfycbxMqHh-lcYmNinrydajF-oKDiHREcg1313jbi6JsfDVliXSNiA/exec"


    reset;

    curl -L \
    -F "action=savePerson" \
    -F "sheetId=11O-DdnPkUTfGmUsZ0jpPNE9GXHuGTFJQu7TKakr8IzE" \
    -F "id=2" \
    -F "facebookName=Adriana Sanchez111" \
    -F "gender=Female" \
    -F "address=Akasya111" \
    -F "ageGroup=" \
    -F "messengerStatus=Active" \
    -F "profileImage=Akasya_Images/Adriana Sanchez.Profile Image.073906.png" \
    -F "referenceDetails=classmate ni Kate111" \
    -F "assignedTo=ann rowen111" \
    -F "preachedBy=Aya111" \
    -F "dateContacted=7/12/2020" \
    -F "remarks=seenzoned" \
    -F "progressStatus=" \
    "https://script.google.com/macros/s/AKfycbxMqHh-lcYmNinrydajF-oKDiHREcg1313jbi6JsfDVliXSNiA/exec"











    ===========================================================





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
