import 'package:sangyaw_app/utils/app_script_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  SharedPreferences sangyawAppPref;

  Globals() {
    SharedPreferences.getInstance().then((value) => sangyawAppPref = value);
  }

  intializePref() async {
    this.sangyawAppPref = await SharedPreferences.getInstance();
    if (this.sangyawAppPref == null) {
      print('preferences intialize error');
      return;
    }
    print('preferences intialize success');
  }

  // BucaweCong
  get congregation {
    if (sangyawAppPref == null) {
      print('Warning cannot get, Sangyaw Preferences is null');
      // return 'BucaweCong';
      return null;
    }
    return sangyawAppPref.getString('congregation');
  }

  setCongregationPassword(String folderId, String password) {
    String crypt = AppScriptUtils.encrypt(password);
    sangyawAppPref.setString('congregation__password__$folderId', crypt);
  }

  bool hasStoredPasswordAndMatch(String folderId, String crypt) {
    String stored =
        sangyawAppPref.getString('congregation__password__$folderId');
    if (stored == null && crypt == null) {
      return true;
    }

    if (stored == crypt) {
      return true;
    }

    return false;
  }

  set congregation(String cong) {
    if (sangyawAppPref == null) {
      print('Warning cannot set, Sangyaw Preferences is null');
      return;
    }
    sangyawAppPref.setString('congregation', cong);
  }
}
