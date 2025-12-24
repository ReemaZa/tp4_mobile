import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {

  /// SAVE
  Future<void> saveCurrentUser(User user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString("current_user_email", user.email ?? "");
    await sp.setString("current_user_name", user.fullName ?? "");

    print("User Saved Successfully");
  }

  /// GET
  Future<User?> getCurrentUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    if (!sp.containsKey("current_user_email")) {
      print("No user found");
      return null;
    }

    User u = User(
      email: sp.getString("current_user_email"),
      fullName: sp.getString("current_user_name"),
    );

    print("User Loaded Successfully");
    return u;
  }

  /// CLEAR
  Future<void> clearCurrentUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.remove("current_user_email");
    await sp.remove("current_user_name");

    print("User Cleared Successfully");
  }
}
