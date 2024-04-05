import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  login(String phone, String password) {
    GetStorage().write('phone', phone);
    // notifyListeners();
  }

  bool checklogin() {
    if (GetStorage().hasData('phone')) {
      return true;
    }
    return false;
  }

  String verificationid = "";

  Future<void> verifyOTP(String otp, void Function() onSuccess) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationid,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      onSuccess();
    } on FirebaseAuthException catch (error) {
      print("Failed to verify OTP: $error");
      showToast("Login Failed");
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print('Failed to send OTP: ${e.message}');
      },
      codeSent: (verificationId, resendToken) {
        verificationid = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> resendOTP(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print('Failed to resend OTP: ${e.message}');
      },
      codeSent: (verificationId, resendToken) {
        verificationid = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  logout() async {
    GetStorage().remove('phone');
    // notifyListeners();
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
