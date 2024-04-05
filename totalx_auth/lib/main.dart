import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/firebase_options.dart';
import 'package:totalx_auth/services/auth_service.dart';
import 'package:totalx_auth/services/user_service.dart';
import 'package:totalx_auth/views/login_view.dart';
import 'package:totalx_auth/views/otp_view.dart';
import 'package:totalx_auth/views/user_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthenticationService(),
        ),
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
      // initialRoute:
      // FirebaseAuth.instance.currentUser != null ? '/userList' : '/',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/otpview': (context) => OtpView(),
        '/userList': (context) => UserView(),
      },
    );
  }
}
