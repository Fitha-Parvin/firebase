
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'google/homeGoogle.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBVOiORo-hkV4TBH_UyxnGjwqyUbvk_vuE",
          appId: "1:251157139515:android:6d8135e754664dd63ecc1e",
          messagingSenderId: "",
          projectId: "sample-893e4"));
  runApp(MaterialApp(
    home: Phone(),
  ));
}

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String userNumber = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  var otpFieldVisibility = false;
  var receivedID = '';

  void verifyUserPhoneNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: userNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) async {});
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          receivedID = verificationId;
          otpFieldVisibility = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  Future<void> verifyOTPcode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: receivedID, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then((value) async {
      if (value.user != true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FireHome()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [SizedBox(height: 90,),
          IntlPhoneField(
            controller: phoneController,
            initialCountryCode: 'IN',
            decoration: InputDecoration(
                hintText: "Phone Number",
                labelText: "Phone",
                border: OutlineInputBorder()),
            onChanged: (val) {
              userNumber = val.completeNumber;
            },
          ),
          Visibility(
              visible: otpFieldVisibility,
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(
                    hintText: 'OTP code',
                    labelText: 'OTP',
                    border: OutlineInputBorder()),
              )),
          ElevatedButton(
              onPressed: () {
                if (otpFieldVisibility) {
                  verifyOTPcode();
                } else {
                  verifyUserPhoneNumber();
                }
              },
              child: Text("Send OTP"))
        ],
      ),
    );
  }
}