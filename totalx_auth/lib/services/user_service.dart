import 'package:totalx_auth/models/user_profile.dart';

class UserService {
  Future<UserProfile?> getUserByEmail(String email) async {
    return UserProfile(
      name: 'John Doe',
      age: '16',
      image: 'assets/images/profile.jpg',
    );
  }

  Future<List<UserProfile>> getUsers() async {
    return [
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
  }
}
