import 'package:flutter/foundation.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:totalx_auth/services/auth_service.dart';
import 'package:totalx_auth/services/user_service.dart';

class UserController with ChangeNotifier {
  final UserService _userService;
  final AuthenticationService _authenticationService;
  UserController(this._userService, this._authenticationService);

  List<UserProfile> _users = [];

  List<UserProfile> get users => _users;

  Future<void> fetchUsers() async {
    _users = await _userService.getUsers();
    notifyListeners();
  }

  Future<bool> login(String phone, String password) async {
    try {
      // Call the login method from the authentication service
      bool isAuthenticated =
          await _authenticationService.login(phone, password);
      if (isAuthenticated) {
        // Handle successful login
        return true;
      } else {
        // Handle unsuccessful login
        return false;
      }
    } catch (error) {
      // Handle error
      print('Error occurred during login: $error');
      return false;
    }
  }
}
