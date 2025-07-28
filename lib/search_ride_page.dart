import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // In real app, this data comes from Firestore or API
    final rides = [
      {
        'driver': 'Ramesh',
        'from': 'Hyderabad',
        'to': 'Warangal',
        'price': '₹150',
        'seats': 2,
      },
      {
        'driver': 'Sita',
        'from': 'Hyderabad',
        'to': 'Nalgonda',
        'price': '₹120',
        'seats': 1,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rides'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text('${ride['from']} → ${ride['to']}'),
              subtitle: Text('Driver: ${ride['driver']} | Seats: ${ride['seats']}'),
              trailing: Text(ride['price'].toString()),
              onTap: () {
                // Navigate to Ride Details screen (optional)
              },
            ),
          );
        },
      ),
    );
  }
}
