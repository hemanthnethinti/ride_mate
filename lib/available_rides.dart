// available_rides_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ride_data_store.dart';

class AvailableRidesPage extends StatelessWidget {
  List<Map<String,dynamic>>? listlen;
  AvailableRidesPage(this.listlen,{super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rides = [
      {
        "name": "Rajesh Kumar",
        "phone": "9876543210",
        "gender": "Male",
        "from": "Bangalore",
        "to": "Mysore",
        "price": 300,
        "rating": 4.5,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Priya Sharma",
        "phone": "9123456780",
        "gender": "Female",
        "from": "Hyderabad",
        "to": "Vizag",
        "price": 450,
        "rating": 4.8,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Amit Verma",
        "phone": "9988776655",
        "gender": "Male",
        "from": "Chennai",
        "to": "Pondicherry",
        "price": 200,
        "rating": 4.2,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Meera Nair",
        "phone": "9012345678",
        "gender": "Female",
        "from": "Kochi",
        "to": "Trivandrum",
        "price": 350,
        "rating": 4.6,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Karan Singh",
        "phone": "9345612780",
        "gender": "Male",
        "from": "Delhi",
        "to": "Agra",
        "price": 400,
        "rating": 4.3,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Ananya Rao",
        "phone": "9503216780",
        "gender": "Female",
        "from": "Pune",
        "to": "Mumbai",
        "price": 500,
        "rating": 4.7,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Suresh Das",
        "phone": "9823451234",
        "gender": "Male",
        "from": "Indore",
        "to": "Bhopal",
        "price": 250,
        "rating": 4.1,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Ritika Malhotra",
        "phone": "9876123400",
        "gender": "Female",
        "from": "Ludhiana",
        "to": "Amritsar",
        "price": 350,
        "rating": 4.9,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Manoj Patil",
        "phone": "9090909090",
        "gender": "Male",
        "from": "Nashik",
        "to": "Aurangabad",
        "price": 280,
        "rating": 4.0,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Nikita Bansal",
        "phone": "9781234567",
        "gender": "Female",
        "from": "Jaipur",
        "to": "Udaipur",
        "price": 320,
        "rating": 4.6,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Deepak Choudhary",
        "phone": "9911223344",
        "gender": "Male",
        "from": "Ahmedabad",
        "to": "Surat",
        "price": 310,
        "rating": 4.4,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
      {
        "name": "Shruti Desai",
        "phone": "9845098450",
        "gender": "Female",
        "from": "Goa",
        "to": "Karwar",
        "price": 260,
        "rating": 4.5,
        "imageUrl":
            "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-3d-illustration-avatar-profile-man-png-image_9945226.png"
      },
    ];

   return Scaffold(
      appBar: AppBar(
        title: const Text("Available Rides"),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
         builder: (context,snapshot){
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: listlen!.length,
        itemBuilder: (context, index) {
          final ride = listlen![index];
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('user').doc(ride['userid']).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (userSnapshot.hasError || !userSnapshot.hasData || !userSnapshot.data!.exists) {
                return const Text('User info not available');
              }
              final userData = userSnapshot.data!.data() as Map<String, dynamic>;
              return Card(
                color: const Color.fromARGB(255, 244, 239, 171),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            //backgroundImage: NetworkImage(ride["imageUrl"]),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData['name'] ?? ' ',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text("Phone: ${userData['phone'] ?? ' '}"),
                               // Text("Gender: ${ride['gender']?? ' '}"),
                                //Text("Fare: ₹${ride['price']?? ' '}"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              //Text(ride['rating'].toString()??"h"),
                            ],
                          ),
                        ],
                      ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green),
                      const SizedBox(width: 4),
                      Text("From: ${ride['PickupLoc']}"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.flag, color: Colors.red),
                      const SizedBox(width: 4),
                      Text("To: ${ride['DropLoc']}"),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async{
                         final postsnap = await FirebaseFirestore.instance
                      .collection('user')
                      .doc(ride['userid'])
                      .collection('posts')
                      .doc(ride['doc']) // You may need to specify the correct post document ID here
                      .update({
                        'requests': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
                      });
                        ScaffoldMessenger.of(context).showSnackBar(
                         
                          SnackBar(content: Text("Request has been sent to ${userData['name']??" "}")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "Request a ride",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
         }
      );
         
         }
      )
      );
    
  }
}
