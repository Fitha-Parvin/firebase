import 'package:firebase/google/registerGoogle.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase.dart';
import 'homeGoogle.dart';

//import 'firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBVOiORo-hkV4TBH_UyxnGjwqyUbvk_vuE",
          appId: "1:251157139515:android:6d8135e754664dd63ecc1e",
          messagingSenderId: "",
          projectId: "sample-893e4"));

  runApp(GetMaterialApp(
    home: LoginFirebase(),
  ));
}

class LoginFirebase extends StatelessWidget {
  LoginFirebase({super.key});
  var formkey1 = GlobalKey<FormState>();
  String? mail;
  String? paswd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
        child: Form(
          key: formkey1,
          child: Column(
            children: [
              const Icon(
                Icons.account_box_outlined,
                size: 50,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Email",
                ),
                validator: (emaill) {
                  if (emaill!.isEmpty &&
                      emaill.contains("@") &&
                      emaill.contains(".")) {
                    return "Invalid email";
                  } else {
                    return null;
                  }
                },
                onSaved: (email2) {
                  mail = email2;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Password",
                ),
                validator: (pass) {
                  if (pass!.isEmpty && pass.length < 6) {
                    return "Password is too small";
                  } else {
                    return null;
                  }
                },
                onSaved: (pass1) {
                  paswd = pass1;
                },
              ),
              const SizedBox(
                height: 34,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey1.currentState!.validate()) {
                    formkey1.currentState!.save();
                    FireHelper()
                        .SignIn(
                      email: mail!,
                      Password: paswd!,
                    )
                        .then((value1) {
                      if (value1 == null) {
                        Get.to(const FireHome());
                      } else {
                        Get.snackbar("error", value1);
                      }
                    });
                  }
                },
                style:
                ElevatedButton.styleFrom(minimumSize: const Size(350, 60)),
                child: Text("Login"),
              ),
              const SizedBox(
                height: 39,
              ),
              Row(
                children: [
                  const Text(
                    "Create an account ?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterFirebase()));
                    },
                    child: const Text("Register"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}