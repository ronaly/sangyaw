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

  set congregation(String cong) {
    if (sangyawAppPref == null) {
      print('Warning cannot set, Sangyaw Preferences is null');
      return;
    }
    sangyawAppPref.setString('congregation', cong);
  }
}
