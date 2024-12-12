
 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'notification.dart';

void main()async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
       options: const FirebaseOptions(
           apiKey: "AIzaSyBVOiORo-hkV4TBH_UyxnGjwqyUbvk_vuE",
           appId: "1:251157139515:android:6d8135e754664dd63ecc1e",
           messagingSenderId: "251157139515",
           projectId: "sample-893e4"));

   runApp(GetMaterialApp(
     home: HomePage(),));
   await NotificationService().registerPushNotificationHandler();
 }



  class HomePage extends StatelessWidget {
    const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(

      );
    }
  }











