// view_request_page.dart

import 'package:flutter/material.dart';
import 'ride_data_store.dart';

class ViewRequestPage extends StatelessWidget {
  const ViewRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ride = RideDataStore.selectedRide;

    return Scaffold(
      appBar: AppBar(title: const Text("Ride Request")),
      body: ride == null
          ? const Center(child: Text("No ride has been requested yet."))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text("Request Details",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Divider(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(ride["imageUrl"]),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ride["name"],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Phone: ${ride["phone"]}"),
                          Text("Gender: ${ride["gender"]}"),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("From: ${ride["from"]}"),
                  Text("To: ${ride["to"]}"),
                  Text("Fare: ₹${ride["price"]}"),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Accepted ride for ${ride["name"]}")));
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("Accept Ride"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
