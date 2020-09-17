// import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  // SharedPreferences sangyawAppPref;
  dynamic sangyawAppPref;

  static final Globals _global = Globals._internal();

  factory Globals() {
    if (_global.sangyawAppPref == null) {
      // SharedPreferences.getInstance().then((value) {
      //   _global.sangyawAppPref = value;
      // }).catchError((onError) {
      //   _global.sangyawAppPref = null;
      // });
    }
    return _global;
  }

  Globals._internal();
  // BucaweCong
  get congregation => sangyawAppPref?.getString('congregation');
  set congregation(String cong) =>
      sangyawAppPref?.setString('congregation', cong);
}
