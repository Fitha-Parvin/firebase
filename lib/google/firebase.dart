import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FireHelper{
  final FirebaseAuth auth =FirebaseAuth.instance;
  get user =>auth.currentUser;

  Future<String?>signUp({required String email ,required String Password})async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: Password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  Future<String?>SignIn({required String email ,required String Password})async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: Password
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void>signOut()async{
    await auth.signOut();
  }


}