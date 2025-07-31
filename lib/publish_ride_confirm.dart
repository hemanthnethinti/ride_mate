import 'package:flutter/material.dart';

class BookedConfirmationPage extends StatelessWidget {
  const BookedConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Image.network(
                "https://png.pngtree.com/png-clipart/20230925/original/pngtree-flat-style-car-sharing-with-free-reservation-map-and-pink-car-png-image_12761433.png", 
                height: 200,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ride Posted Succesfully',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // go back or to home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(80, 40),
                ),
                child: const Text("OK"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
