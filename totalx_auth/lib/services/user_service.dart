import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:totalx_auth/models/user_profile.dart';

List<UserProfile> allusers = [];
List<UserProfile> allusersx = [
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
  List<UserProfile> users = [];

  UserService() {
    listentousers();
  }

  listentousers() {
    FirebaseFirestore.instance
        .collection('datas')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      allusers = [];
      getUsersFromFirestore();
      // notifyListeners();
    });
  }

  void getUsersFromFirestore() {
    allusers = [];
    // users = [];
    FirebaseFirestore.instance
        .collection('datas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        allusers.add(UserProfile(
          name: doc['name'],
          age: doc['age'],
          image: doc['image'],
        ));
      });
      users = allusers;
      notifyListeners();
    }).catchError((error) {
      print("Failed to get users: $error");
    });
  }

  void searchuser(String s) {
    users = allusers
        .where((e) => e.name.toLowerCase().contains(s.toLowerCase()))
        .toList();
    notifyListeners();
  }

  adduser(String name, String age, String image) async {
    String? imageUrl = await uploadImageToFirebaseStorage(File(image));
    image = imageUrl ?? image;
    FirebaseFirestore.instance.collection('datas').add({
      'name': name,
      'age': age,
      'image': image,
    }).then((_) {
      // allusers.add(UserProfile(name: name, age: age, image: image));
      getUsersFromFirestore();
      // users.add(UserProfile(name: name, age: age, image: imageUrl ?? image));
      // notifyListeners();
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('usr_imgs')
          .child('${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      String imageUrl = await (await uploadTask).ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      print("Failed to upload image: $error");
      return null;
    }
  }

  void sortByAge(String option) {
    switch (option) {
      case 'All':
        getUsersFromFirestore();
        break;
      case 'Elder':
        users = allusers.where((e) => int.parse(e.age) >= 60).toList();
        break;
      case 'Younger':
        users = allusers.where((e) => int.parse(e.age) < 60).toList();
        break;
    }
    notifyListeners();
  }
}
