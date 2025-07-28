import 'package:flutter/material.dart';

class PostRidePage extends StatelessWidget {
  const PostRidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer A Ride'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(label: 'From Location'),
            _buildTextField(label: 'To Location'),
            _buildTextField(label: 'Date'),
            _buildTextField(label: 'Time'),
            _buildTextField(label: 'Available Seats', keyboardType: TextInputType.number),
            _buildTextField(label: 'Price per Seat', keyboardType: TextInputType.number),
            _buildTextField(label: 'Vehicle Info (Model, Color, Number)'),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Gender Preference'),
              items: ['Any', 'Male', 'Female'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Post Ride'),
            )
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
