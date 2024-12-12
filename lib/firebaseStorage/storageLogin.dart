import 'package:flutter/material.dart';

void main(){
runApp(MaterialApp(home: storageLogin(),));
}
class storageLogin extends StatefulWidget {


  @override
  State<storageLogin> createState() => _storageLoginState();
}

class _storageLoginState extends State<storageLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  Column(children: [
         Icon(Icons.person),
         TextField(decoration: InputDecoration(hintText: "Email"),),
         TextField(decoration: InputDecoration(hintText: "Password"),),
         ElevatedButton(onPressed: (){}, child: Text("Login"))
       ],
          ),
    );
  }
}
