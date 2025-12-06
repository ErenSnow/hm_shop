import 'package:shared_preferences/shared_preferences.dart';

class Tokenmanager {
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  init() {}

  setToken(String val) {
    _getInstance().then((value) {
      value.setString("token", val);
    });
  }

  getToken() {
    _getInstance().then((value) {
      return value.getString("token");
    });
  }

  removeToken() {
    _getInstance().then((value) {
      value.remove("token");
    });
  }
}

final tokenMangager = Tokenmanager();
