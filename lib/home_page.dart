import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}
Future<void> signOut()async{
   await FirebaseAuth.instance.signOut();
}
class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Mate APP!',style: TextStyle(),),
        actions: [
          ElevatedButton(onPressed: (){
            signOut();
          }, child: Text("signOut"))
        ],
      ),
    );
  }
}