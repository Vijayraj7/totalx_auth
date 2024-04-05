import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/services/auth_service.dart';

String publicphone = "";

class OtpView extends StatelessWidget {
  // String phone;

  // OtpView({required this.phone});
  Color bcolor = const Color.fromARGB(255, 227, 227, 227);
  List<String> otpDigits = List.generate(6, (index) => '');
  Stream<int> countdownStream() {
    StreamController<int> controller = StreamController<int>();
    int secondsRemaining = 59;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        controller.add(secondsRemaining);
        secondsRemaining--;
      } else {
        timer.cancel();
        controller.close();
      }
    });
    return controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    InputBorder border =
        OutlineInputBorder(borderSide: BorderSide(color: bcolor));
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              child: Center(
                child: Image.asset(
                  'assets/otpimg.png',
                  height: 160,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("OTP Verification",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
            const SizedBox(
              height: 10,
            ),
            Text(
                "Enter the verification code we just sent to your number +91 *******" +
                    publicphone[publicphone.length - 2] +
                    publicphone[publicphone.length - 1] +
                    ".",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: List.generate(
                6,
                (index) => Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.red),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // if (value.length == 1 && index < 5) {
                      //   FocusScope.of(context).nextFocus();
                      // } else if (value.isEmpty && index > 0) {
                      //   FocusScope.of(context).previousFocus();
                      // }
                      if (value.length == 1) {
                        otpDigits[index] = value;
                        if (index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                      } else if (value.isEmpty && index > 0) {
                        otpDigits[index] = '';
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<int>(
              stream: countdownStream(),
              builder: (context, snapshot) {
                // if (snapshot.hasData) {
                return Center(
                  child: Text(
                    '${snapshot.data} Sec',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
                // } else if (snapshot.hasError) {
                //   return Center(
                //     child: Text(
                //       'Error: ${snapshot.error}',
                //       style: TextStyle(
                //         color: Colors.red,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   );
                // } else {
                //   return CircularProgressIndicator(); // Loading indicator while waiting for countdown to start
                // }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: "Don't Get Otp? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Resend',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Provider.of<AuthenticationService>(context,
                                listen: false)
                            .resendOTP(publicphone);
                      },
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // AuthenticationService().login(phone, "123");
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, '/userList', (route) => false);
                  String otp = otpDigits.join().trim();
                  String verificationId =
                      ''; // Get the verification ID from previous screen or storage
                  if (otp.isNotEmpty) {
                    await Provider.of<AuthenticationService>(context,
                            listen: false)
                        .verifyOTP(otp, () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/userList', (route) => false);
                    });
                  } else {
                    // Show error message or handle empty OTP
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text('Verify',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
