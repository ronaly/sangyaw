import 'dart:io' as Io;
import 'package:date_time_format/date_time_format.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'dart:convert';
import 'package:sangyaw_app/model/person.dart';
import 'package:mime_type/mime_type.dart';

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
        settings.firstWhere((element) => element['folderId'] == instance);

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
        settings.firstWhere((element) => element['folderId'] == instance);
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
        var val = decrypt(json['md5sha1']);
        List sheets = json['sheets'];
        return {
          'folderId': json['folderId'],
          'folderName': json['folderName'],
          'sheets': sheets,
          'crypt': json['md5sha1'],
          'password': val,
          // 'password': json['md5sha1'] != null ? decrypt(json['md5sha1']) : null,
        };
      }).toList();
      return settings;
    });
  }

  static var publicKey;
  static var privKey;
  static var strPublicKey;
  static var strPrivKey;

  static inialized() async {
    // strPublicKey = await rootBundle.loadString("assets/public.pem");
    // strPrivKey = await rootBundle.loadString("assets/private.pem");

    // publicKey = RSAKeyParser().parse(strPublicKey) as RSAPublicKey;
    // privKey = RSAKeyParser().parse(strPrivKey) as RSAPrivateKey;
  }

  static String decrypt(String str) {
    if (str == null) {
      return null;
    }
    var text = str;
    for (var i = 0; i < 5; i++) {
      text = utf8.decode(base64.decode(text));
    }
    return text;
  }

  static String encrypt(String str) {
    if (str == null) {
      return null;
    }
    var text = str;
    for (var i = 0; i < 5; i++) {
      text = base64.encode(utf8.encode(text));
    }
    return text;
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

  static Future<dynamic> createSheet(String folderId, String sheetName) {
    Map<String, dynamic> data = {};
    data['name'] = sheetName;
    data['folderId'] = folderId;
    data['action'] = 'createSheet';

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
          print('======= Create Sheet Response Data ======');
          print(res.data);
          return res.data;
        });
      }

      print('======= Create Sheet Response Data ======');
      print(res.data);

      return res.data;
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
