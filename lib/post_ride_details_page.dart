import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_mate/Database/posts.dart';
import 'package:ride_mate/publish_ride_confirm.dart';

class PostRideDetailsPage extends StatelessWidget {
  final String pickupLocation;
  final String dropLocation;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final TimeOfDay? returnTime;
  final List<String> selectedDays;
  final String price;
  final bool isTwoWay;

  const PostRideDetailsPage({
    super.key,
    required this.pickupLocation,
    required this.dropLocation,
    required this.startTime,
    required this.endTime,
    this.returnTime,
    required this.selectedDays,
    required this.price,
    required this.isTwoWay,
  });

  String formatTime(TimeOfDay? time) {
    if (time == null) return "N/A";
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text("Ride Summary"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Header Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://cdn-icons-png.freepik.com/256/1150/1150643.png',
                height: 120,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Card Container
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  rideDetail(Icons.location_on, "From", pickupLocation),
                  rideDetail(Icons.flag, "To", dropLocation),
                  rideDetail(Icons.access_time, "Start Time", formatTime(startTime)),
                  rideDetail(Icons.timer_off, "Drop Time", formatTime(endTime)),
                  if (isTwoWay && returnTime != null)
                    rideDetail(Icons.loop, "Return Time", formatTime(returnTime)),
                  rideDetail(Icons.calendar_today, "Days", selectedDays.isEmpty ? "None" : selectedDays.join(', ')),
                  rideDetail(Icons.currency_rupee, "Price", "₹ $price"),
                ],
              ),
            ),
          ),

          // Confirm Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: ()async {
                User? user= FirebaseAuth.instance.currentUser;
                      await Posts.setPost(user, pickupLocation,dropLocation,startTime,endTime, selectedDays, price);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const BookedConfirmationPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0); // from bottom
                      const end = Offset.zero;
                      const curve = Curves.easeOut;

                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Text(
                "Confirm & Publish Ride",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rideDetail(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepOrange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title:",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
