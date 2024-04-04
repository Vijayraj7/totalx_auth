import 'package:flutter/material.dart';
import 'package:totalx_auth/models/user_profile.dart';

class UserService with ChangeNotifier {
  List<UserProfile> allusers = [
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
  List<UserProfile> users = [
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

  void searchuser(String s) {
    users = allusers.where((e) => e.name.contains(s)).toList();
    notifyListeners();
  }

  void adduser(String name, String age, String image) {
    users.add(UserProfile(name: name, age: age, image: image));
    allusers.add(UserProfile(name: name, age: age, image: image));
    notifyListeners();
  }

  void sortByAge(String option) {
    switch (option) {
      case 'All':
        users = List.from(allusers);
        break;
      case 'Elder':
        users = allusers.where((e) => int.parse(e.age) >= 60).toList();
        break;
      case 'Younger':
        users = allusers.where((e) => int.parse(e.age) < 60).toList();
        ;
        break;
    }
    notifyListeners();
  }
}
