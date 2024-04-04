import 'package:flutter/material.dart';
import 'package:totalx_auth/models/user_profile.dart';

List<UserProfile> allusers = [
  UserProfile(
    name: 'Martin Dokidis',
    age: '34',
    image: 'assets/usr/usr0.png',
  ),
  UserProfile(
    name: 'Marilyn Rosser',
    age: '46',
    image: 'assets/usr/usr1.png',
  ),
  UserProfile(
    name: 'Cristofer Lipshutz',
    age: '27',
    image: 'assets/usr/usr2.png',
  ),
  UserProfile(
    name: 'Wilson Botosh',
    age: '67',
    image: 'assets/usr/usr3.png',
  ),
  UserProfile(
    name: 'Anika Saris',
    age: '54',
    image: 'assets/usr/usr4.png',
  ),
  UserProfile(
    name: 'Phillip Gouse',
    age: '72',
    image: 'assets/usr/usr5.png',
  ),
  UserProfile(
    name: 'Wilson Bergson',
    age: '84',
    image: 'assets/usr/usr6.png',
  ),
];

class UserService with ChangeNotifier {
  List<UserProfile> users = allusers;

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
