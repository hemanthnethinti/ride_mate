import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRides extends StatefulWidget {
  final List<Map<String,dynamic>>? list;
  const MyRides({required this.list, super.key});
  
  @override
  State<MyRides> createState() => _MyRidesState();
}
class _MyRidesState extends State<MyRides> {
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rides'),
        backgroundColor: Colors.orange,
      ),
      body: widget.list == null || widget.list!.isEmpty
          ? const Center(
              child: Text(
                'No rides found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: widget.list!.length,
              itemBuilder: (context, index) {
                print(widget.list?.length);
                final ride = widget.list![index];
                final riderId = ride['userid'];
                
                if (riderId == null) {
                  return const Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Invalid ride data'),
                    ),
                  );
                }
                
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('user').doc(riderId).get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ListTile(
                          leading: CircularProgressIndicator(),
                          title: Text('Loading...'),
                        );
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists || snapshot.data!.data() == null) {
                        return const ListTile(
                          title: Text('User data not found'),
                        );
                      }

                      final riderData = snapshot.data!.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text("Ride to ${riderData['email'] ?? 'Unknown'}"),
                        subtitle: Text("Rider: ${riderData['name'] ?? 'Unknown'}"),
                        trailing: Text("Phone: ${riderData['phone'] ?? 'N/A'}"),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}