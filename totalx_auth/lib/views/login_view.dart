import 'package:flutter/material.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    String phone = "";

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                userController.login(phone, 'password123').then((success) {
                  if (success) {
                    // Navigate to the next screen upon successful login
                    Navigator.pushReplacementNamed(context, '/userList');
                  } else {}
                });
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
