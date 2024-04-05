import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/services/auth_service.dart';
import 'package:totalx_auth/services/user_service.dart';
import 'package:totalx_auth/views/login_view.dart';
import 'package:totalx_auth/views/otp_view.dart';
import 'package:totalx_auth/views/user_view.dart';

void main() async {
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserService(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => AuthenticationService(),
        // ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AuthenticationService().checklogin() ? '/userList' : '/',
      // initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/otpview': (context) => OtpView(),
        '/userList': (context) => UserView(),
      },
    );
  }
}
