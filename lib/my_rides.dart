import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRides extends StatefulWidget {
  List<Map<String,dynamic>>? list;
   MyRides({required this.list, super.key});
  @override
  State<MyRides> createState() => _MyRidesState();
}
class _MyRidesState extends State<MyRides> {
  User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.list?.length,
        itemBuilder:(context,index){
          print(widget.list?.length);
          final ride=widget.list?[index];
           final riderId = ride?['userid'];
            return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('user').doc(riderId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }

    if (!snapshot.hasData || !snapshot.data!.exists || snapshot.data!.data() == null) {
      return const ListTile(
        title: Text('User data not found'),
      );
    }

        final riderData = snapshot.data!.data() as Map<String, dynamic>;
        return ListTile(
          title: Text("Ride to ${riderData['email']}"),
          subtitle: Text("Rider: ${riderData['name']}"),
          trailing: Text("Phone: ${riderData['uid']}"),
        );
      },
    );
        }
        )
    );
  }
}