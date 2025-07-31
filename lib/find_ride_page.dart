import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ride_mate/available_rides.dart';
import 'package:ride_mate/search_ride_page.dart';

class FindRidePage extends StatefulWidget {
  const FindRidePage({super.key});

  @override
  State<FindRidePage> createState() => _FindRidePageState();
}

class _FindRidePageState extends State<FindRidePage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _genderPref = 'Any';
  double _maxFare = 500;
  int _seats = 1;
  bool _verifiedOnly = false;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.location_on, color: Colors.green),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildSelectableTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find A Ride',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
          shadowColor: Colors.grey.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _fromController,
                  label: 'From (Pickup Location)',
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _toController,
                  label: 'To (Drop Location)',
                ),
                const SizedBox(height: 15),
                _buildSelectableTile(
                  title: _selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                  icon: Icons.calendar_today,
                  onTap: _pickDate,
                ),
                const SizedBox(height: 10),
                _buildSelectableTile(
                  title: _selectedTime == null
                      ? 'Select Time'
                      : 'Time: ${_selectedTime!.format(context)}',
                  icon: Icons.access_time,
                  onTap: _pickTime,
                ),
                const SizedBox(height: 15),
      DropdownButtonFormField<String>(
        value: _genderPref,
        decoration: _inputDecoration('Gender Preference'),
        items: ['Any', 'Male', 'Female']
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {
          if (val != null) setState(() => _genderPref = val);
        },
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Seats Required", style: TextStyle(fontSize: 16)),
          DropdownButton<int>(
            value: _seats,
            items: List.generate(6, (i) => i + 1)
                .map((s) => DropdownMenuItem(value: s, child: Text(s.toString())))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _seats = val);
            },
          ),
        ],
      ),
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Max Fare: ₹${_maxFare.round()}"),
          Slider(
            value: _maxFare,
            min: 50,
            max: 1000,
            divisions: 19,
            label: '₹${_maxFare.round()}',
            onChanged: (val) => setState(() => _maxFare = val),
          ),
        ],
      ),
      SwitchListTile(
        title: const Text("Verified Bikers Only"),
        value: _verifiedOnly,
        onChanged: (val) => setState(() => _verifiedOnly = val),
      ),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchResultsPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        label: const Text(
          "Search Ride",
          style: TextStyle(color: Colors.black),
        ),
      ),
      const SizedBox(height: 12),
      OutlinedButton.icon(
        icon: const Icon(Icons.list_alt),
        label: const Text("Available Rides"),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AvailableRidesPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // from right
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                final tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.orange.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.orange),
          ),
          foregroundColor: Colors.black,
        ),
      ),
    ],
            )
          
  )
        )
        )
    );
  }
}
