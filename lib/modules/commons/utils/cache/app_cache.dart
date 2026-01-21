import "package:shared_preferences/shared_preferences.dart";

class AppCache {
  AppCache._();

  static final AppCache instance = AppCache._();

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUserId(String userId) async {
    await _prefs.setString("userId", userId);
  }

  String? getUserId() {
    return _prefs.getString("userId");
  }
}
