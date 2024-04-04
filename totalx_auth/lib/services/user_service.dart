import 'package:totalx_auth/models/user_profile.dart';

class UserService {
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
