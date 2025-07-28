import 'package:flutter/material.dart';
import 'package:ride_mate/search_ride_page.dart';

class FindRidePage extends StatelessWidget {
  const FindRidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find A Ride'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(label: 'From'),
            _buildTextField(label: 'To'),
            _buildTextField(label: 'Date'),
            _buildTextField(label: 'Time'),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Gender Preference'),
              items:
                  ['Any', 'Male', 'Female']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) {},
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
              child: const Text("Search Ride"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
