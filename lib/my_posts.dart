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
      appBar: AppBar(
        title: const Text('My Posts'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('user').doc(user?.uid).collection('posts').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No posts found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          
          final posts = snapshot.data!.docs;
          
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final postData = posts[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(postData['PickupLoc'] ?? 'Unknown location'),
                  subtitle: Text(postData['DropLoc'] ?? 'Unknown destination'),
                  trailing: Text(postData['date'] ?? 'No date'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}