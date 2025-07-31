import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text("Ride Details"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Top Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://cdn-icons-png.freepik.com/256/1150/1150643.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Details Container
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView(
                    children: [
                      detailRow("From:", pickupLocation),
                      const SizedBox(height: 12),
                      detailRow("To:", dropLocation),
                      const SizedBox(height: 12),
                      detailRow("Start Time:", formatTime(startTime)),
                      const SizedBox(height: 12),
                      detailRow("Drop Time:", formatTime(endTime)),
                      if (isTwoWay && returnTime != null) ...[
                        const SizedBox(height: 12),
                        detailRow("Return Time:", formatTime(returnTime)),
                      ],
                      const SizedBox(height: 12),
                      detailRow("Travelling Days:", selectedDays.isEmpty ? "None" : selectedDays.join(', ')),
                      const SizedBox(height: 12),
                      detailRow("Charge:", "₹ $price"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Confirm Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Confirm & Publish"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ride successfully posted!")),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
