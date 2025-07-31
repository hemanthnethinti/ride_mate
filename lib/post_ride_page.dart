import 'package:flutter/material.dart';
import 'post_ride_details_page.dart';

class PostRidePage extends StatefulWidget {
  const PostRidePage({super.key});

  @override
  State<PostRidePage> createState() => _PostRidePageState();
}

class _PostRidePageState extends State<PostRidePage> {
  bool isTwoWay = false;
  List<String> selectedDays = [];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TimeOfDay? returnTime;

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Widget buildDayChip(String day) {
    final isSelected = selectedDays.contains(day);
    return ChoiceChip(
      label: Text(day),
      selected: isSelected,
      selectedColor: Colors.blue,
      onSelected: (selected) {
        setState(() {
          isSelected ? selectedDays.remove(day) : selectedDays.add(day);
        });
      },
      backgroundColor: Colors.grey[300],
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }

  Future<void> pickTime(ValueChanged<TimeOfDay> onPicked) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => onPicked(picked));
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return "Select";
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Map Your Route"),
          backgroundColor: Colors.orange,
          leading: const BackButton(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        buildToggle("One Way", false),
                        buildToggle("Two Way", true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        buildLocationRow(
                          icon: Icons.radio_button_checked,
                          label: "Pickup Location",
                          controller: pickupController,
                          time: startTime,
                          onTapTime: () => pickTime((time) => startTime = time),
                        ),
                        const Divider(),
                        buildLocationRow(
                          icon: Icons.location_on_outlined,
                          label: "DropOff Location",
                          controller: dropController,
                          time: endTime,
                          onTapTime: () => pickTime((time) => endTime = time),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (isTwoWay) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.refresh, size: 24),
                        const SizedBox(width: 10),
                        const Text("Return Time:"),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => pickTime((time) => returnTime = time),
                          child: Text(
                            formatTime(returnTime),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 25),
                  const Text('Travelling Days', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: days.map(buildDayChip).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text("Charge for the Ride (₹)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter amount",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.currency_rupee),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostRideDetailsPage(
                            pickupLocation: pickupController.text,
                            dropLocation: dropController.text,
                            startTime: startTime,
                            endTime: endTime,
                            returnTime: isTwoWay ? returnTime : null,
                            selectedDays: selectedDays,
                            price: priceController.text,
                            isTwoWay: isTwoWay,
                          ),
                        ),
                      );
                    },
                    child: const Text("Post Ride",style: TextStyle(color: Colors.black),),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50),backgroundColor: Colors.orange),
                    onPressed: () {},
                    icon: const Icon(Icons.directions_car),
                    label: const Text("View Requests",style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocationRow({
  required IconData icon,
  required String label,
  required TextEditingController controller,
  required TimeOfDay? time,
  required VoidCallback onTapTime,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onTapTime,
            child: Text(
              formatTime(time),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () {
          },
          icon: const Icon(Icons.location_on, color: Colors.orange),
          label: const Text(
            "Select on Map",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
      const SizedBox(height: 8),
    ],
  );
}



  Widget buildToggle(String title, bool isThisTwoWay) {
    bool isSelected = isTwoWay == isThisTwoWay;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isTwoWay = isThisTwoWay),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
