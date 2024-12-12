
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'firebase.dart';
import 'logingoogle.dart';

class FireHome extends StatelessWidget {
  const FireHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Welcome"),
          ElevatedButton(onPressed: (){
            FireHelper().signOut().then((v){
              Get.to(LoginFirebase());
            });
          }, child: Text("LogOut"))
        ],
      ),

    );
  }
}