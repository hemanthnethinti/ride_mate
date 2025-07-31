import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ride_mate/find_ride_page.dart';
import 'package:ride_mate/globals.dart';
import 'package:ride_mate/my_posts.dart';
import 'package:ride_mate/my_rides.dart';
import 'package:ride_mate/post_ride_page.dart';
import 'package:ride_mate/traveler_details.dart';
import 'package:ride_mate/widgets/app_drawer.dart';

class MyHome extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPhone;

  final RideSearchDetails? rideDetails;

  const MyHome({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    this.rideDetails, 
  });

  @override
  State<MyHome> createState() => _MyHomeState();
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}


class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;

  // Move _buildRideOption above build method
  Widget _buildRideOption({
    required String title,
    required String subtitle,
    required String imageUrl,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(subtitle, style: const TextStyle(fontSize: 16)),
                ],
              ),
              Image.network(imageUrl, height: 150, width: 130),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

}
