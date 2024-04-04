import 'package:flutter/material.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/services/auth_service.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String phone = "";

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              onChanged: (s) {
                phone = s;
              },
              decoration: InputDecoration(hintText: "PhoneNumber"),
            ),
            ElevatedButton(
              onPressed: () {
                AuthenticationService().login(phone, "123");
                Navigator.pushReplacementNamed(context, '/userList');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
