import 'package:flutter/widgets.dart';
import 'package:totalx_auth/models/user_profile.dart';

class UserService with ChangeNotifier {
  List users = [
    UserProfile(
      name: 'Alice',
      age: '17',
      image: 'assets/images/alice.jpg',
    ),
    UserProfile(
      name: 'Bob',
      age: '21',
      image: 'assets/images/bob.jpg',
    ),
  ];
  adduser() {
    users.add(UserProfile(name: 'hi', age: '32', image: ''));
    notifyListeners();
  }
}
