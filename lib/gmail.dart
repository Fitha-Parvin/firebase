import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sign_in/google_sign_in.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAng3b90pGlrq-U9sjCx9nXI_1o8zWqtz8",
          appId: "1:656617175855:android:30c5f265a9f4b158177fda",
          messagingSenderId: "",
          projectId: "fir-eg-b8e88",
          storageBucket: "fir-eg-b8e88.appspot.com"));
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Gmailauth(),
  ));
}

class Gmailauth extends StatefulWidget {
  const Gmailauth({super.key});

  @override
  State<Gmailauth> createState() => _GmailauthState();
}

class _GmailauthState extends State<Gmailauth> {
  ValueNotifier userCredential = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Google Sign In"),
        ),
        body: ValueListenableBuilder(
            valueListenable: userCredential,
            builder: (context, value, child) {
              return (userCredential.value == '' ||
                  userCredential.value == null)
                  ? Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Wrap(children: [
                    IconButton(
                      iconSize: 40,
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        userCredential.value = await signInWithGoogle();
                        if (userCredential.value != null)
                          print(userCredential.value.user!.email);
                      },
                    ),
                    IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.facebook,
                          size: 40,
                          color: Colors.blueAccent,
                        ))
                  ]),
                ),
              )
                  : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1.5, color: Colors.black54)),
                      child: Image.network(
                          userCredential.value.user!.photoURL.toString()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(userCredential.value.user!.displayName
                        .toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(userCredential.value.user!.email.toString()),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          bool result = await signOutFromGoogle();
                          if (result) userCredential.value = '';
                        },
                        child: const Text('Logout'))
                  ],
                ),
              );
            }));
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}