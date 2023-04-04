import 'package:shared_preferences/shared_preferences.dart';

class UserSavedData {
  static SharedPreferences? preferences;

//initialize shared preferences
  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  // saving email
  static saveEmail(String email) async {
    print("saving email " + email);
    return await preferences?.setString('email', email);
  }

  // reading email
  static String? get getEmail => preferences?.getString('email') ?? "";
}
