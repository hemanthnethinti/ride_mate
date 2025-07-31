import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find A Ride'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(controller: _fromController, label: 'From (Pickup Location)'),
            const SizedBox(height: 10),
            _buildTextField(controller: _toController, label: 'To (Drop Location)'),
            const SizedBox(height: 10),
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Select Date'
                  : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ListTile(
              title: Text(_selectedTime == null
                  ? 'Select Time'
                  : 'Time: ${_selectedTime!.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _genderPref,
              decoration: InputDecoration(labelText: 'Gender Preference',border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
              )),
              items: ['Any', 'Male', 'Female']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _genderPref = val);
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Seats Required",style: TextStyle(fontSize: 16),),
                  DropdownButton<int>(
                    value: _seats,
                    items: List.generate(6, (i) => i + 1)
                        .map((s) => DropdownMenuItem(value: s, child: Text(s.toString())))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _seats = val);
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Max Fare: ₹",style: TextStyle(fontSize: 16),),
                  Expanded(
                    child: Slider(
                      value: _maxFare,
                      min: 50,
                      max: 1000,
                      divisions: 19,
                      label: '₹${_maxFare.round()}',
                      onChanged: (val) => setState(() => _maxFare = val),
                    ),
                  ),
                ],
              ),
            ),
            SwitchListTile(
              title: const Text("Verified Bikers Only"),
              value: _verifiedOnly,
              onChanged: (val) => setState(() => _verifiedOnly = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
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
              ),
              child: const Text("Search Ride",style: TextStyle(fontSize: 16,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
