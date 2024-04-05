import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/services/auth_service.dart';

class OtpView extends StatelessWidget {
  Color bcolor = const Color.fromARGB(255, 227, 227, 227);

  String phone = "";
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
            const Text(
                "Enter the verification code we just sent to your number +91 *******21.",
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
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
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
            Center(
              child: const Text(
                '59 Sec',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
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
                    recognizer: TapGestureRecognizer()..onTap = () {},
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
                onPressed: () {
                  AuthenticationService().login(phone, "123");
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/userList', (route) => false);
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
