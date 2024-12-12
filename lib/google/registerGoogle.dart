
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'firebase.dart';
import 'logingoogle.dart';
// void main(){
//   runApp(MaterialApp(home:RegisterFirebase() ,));
// }
class RegisterFirebase extends StatelessWidget {
  RegisterFirebase({super.key});

  String ?email;
  String? passwd;
  String?name;
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 180,left: 10,right: 10),
        child: Form(
          key: formkey,
          child: Column(children:[ Icon(Icons.account_box_outlined,size: 50,),
            SizedBox(height: 40,),
            TextFormField(
              decoration: InputDecoration( border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
                hintText: "Username",
              ),
              validator: (name){
                if(name!.isEmpty){
                  return "Enter some value";

                }
                else{
                  return null;
                }
              },
              onSaved: (ename){
                name=ename;
              },
            ),SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration( border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
                hintText: "Email",
              ),
              validator: (emaill){
                if(emaill!.isEmpty && emaill.contains("@") && emaill.contains(".")){
                  return "Invalid email";

                }
                else{
                  return null;
                }
              },
              onSaved: (email2){
                email=email2;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration( border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
                hintText: "Password",
              ),
              validator: (pass){
                if(pass!.isEmpty && pass.length<6){
                  return "Password is too small";

                }
                else{
                  return null;
                }
              },
              onSaved: (pass1){
                passwd=pass1;
              },
            ),

            SizedBox(height: 34,),
            ElevatedButton(onPressed: (){
              if(formkey.currentState!.validate()){
                formkey.currentState!.save();
                FireHelper().signUp(email:email! ,Password:passwd!, ).then((value){
                  if(value==null){
                    Get.to(LoginFirebase());
                  }
                  else{
                    Get.snackbar("error", value);
                  }
                });
              }

            }, child: Text("Register"),
              style: ElevatedButton.styleFrom(minimumSize: Size(350, 60)),),

            SizedBox(
              height: 39,

            ),
            Row(
              children: [
                Text("Already have an account ?",),
                TextButton(onPressed: (){}, child: Text("Login"),),
              ],
            )
          ],
          ),
        ),
      ),
    );
  }
}