import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/services/auth_service.dart';
import 'package:totalx_auth/views/otp_view.dart';

class LoginView extends StatelessWidget {
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
                  'assets/regimg.png',
                  height: 160,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Enter Phone Number",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (s) {
                phone = s;
              },
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Enter Phone Number *",
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                disabledBorder: border,
                errorBorder: border,
                focusedBorder: border,
                focusedErrorBorder: border,
                enabledBorder: border,
                border: border,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'By Continuing, I agree to TotalX’s ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms and conditions',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(
                    text: ' & ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'privacy policy',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            SizedBox(
              width: width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String phoneNumber = phone.trim();
                  if (phoneNumber.isNotEmpty) {
                    publicphone = phoneNumber;
                    Provider.of<AuthenticationService>(context, listen: false)
                        .sendOTP(phoneNumber);
                    Navigator.pushNamed(context, '/otpview');
                  } else {
                    // Show error message or handle empty phone number
                  }
                  // Navigator.pushNamed(context, '/otpview');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text('Get OTP',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
