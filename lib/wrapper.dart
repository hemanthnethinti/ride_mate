import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_mate/home_page.dart';
import 'package:ride_mate/login_page.dart';
class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        if(snapshot.hasData){
        if (snapshot.data!.emailVerified) {
          return MyHome();
        } else {
          return LoginPage();
        }
        }
        else{
          return LoginPage();
        }
      }
    );
  }
}