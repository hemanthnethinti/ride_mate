// available_rides_page.dart

import 'package:flutter/material.dart';
import 'ride_data_store.dart';
import 'view_request_page.dart';

class AvailableRidesPage extends StatelessWidget {
  const AvailableRidesPage({super.key});

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
      appBar: AppBar(title: const Text("Available Rides")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(ride["imageUrl"]),
              ),
              title: Text(ride["name"]),
              subtitle: Text("${ride["from"]} ➡ ${ride["to"]}"),
              trailing: ElevatedButton(
                onPressed: () {
                  RideDataStore.selectedRide = ride;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Request sent to ${ride["name"]}")),
                  );
                },
                child: const Text("Request Ride"),
              ),
            ),
          );
        },
      ),
    );
  }
}
