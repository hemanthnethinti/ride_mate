import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}
  User? user = FirebaseAuth.instance.currentUser;
 late final li;
getPosts()async{
 li =await FirebaseFirestore.instance.collection('user').doc(user?.uid).collection('posts').get();
}
class _MyPostsState extends State<MyPosts> {
  @override
  void initState() {
    super.initState();
    //getPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future:FirebaseFirestore.instance.collection('user').doc(user?.uid).collection('posts').get(),
         builder: (context,snapshot){
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(snapshot.data!.docs.toList()[1].data()['PickupLoc']),
          );
         })
    );
  }
}