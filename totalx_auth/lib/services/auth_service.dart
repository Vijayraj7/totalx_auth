import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationService {
  login(String phone, String password) {
    GetStorage().write('phone', phone);
    // notifyListeners();
  }

  bool checklogin() {
    if (GetStorage().hasData('phone')) {
      return true;
    }
    return false;
  }

  logout() async {
    GetStorage().remove('phone');
    // notifyListeners();
  }
}
