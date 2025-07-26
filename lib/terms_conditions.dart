import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 16, height: 1.5),
                children: const [
                  TextSpan(
                    text:
                        "Welcome to RideMate, a platform that connects solo bikers with travelers heading to the same destination. By using this service, you agree to the following terms and conditions. ",
                  ),
                  TextSpan(
                    text:
                        "These rules apply to both bikers and travelers to ensure a safe, respectful, and fair travel experience.\n\n",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "• Accurate Information: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "All users must register with accurate and truthful information, including their name, phone number, and contact details.\n\n",
                  ),
                  TextSpan(
                    text: "• Biker Responsibilities: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Bikers must provide correct trip details such as destination, time, available seats, and vehicle type.\n\n",
                  ),
                  TextSpan(
                    text: "• Legal Documents: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Bikers must hold a valid driving license, vehicle registration, and insurance.\n\n",
                  ),
                  TextSpan(
                    text: "• Ride Costs: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Prices must be pre-agreed. No surprise charges after the ride.\n\n",
                  ),
                  TextSpan(
                    text: "• Behavior and Safety: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Respectful behavior is mandatory. No illegal or suspicious items.\n\n",
                  ),
                  TextSpan(
                    text: "• Reporting Issues: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "Users can report any misconduct.\n\n",
                  ),
                  TextSpan(
                    text: "• Emergency Contact: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Add emergency contact details for safety and support.\n\n",
                  ),
                  TextSpan(
                    text: "• Restrictions: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "No illegal deliveries or misuse of the app. RideMate is a facilitator, not liable for disputes or delays.\n\n",
                  ),
                  TextSpan(
                    text: "• Updates: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "Terms may be updated anytime. Continued usage implies agreement.\n\n",
                  ),
                  TextSpan(
                    text:
                        "By signing up or booking a ride, you confirm that you have read, understood, and agreed to these terms and conditions.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D2B45),
                    minimumSize: const Size(160, 60),
                  ),
                  child: const Text('Accept',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D2B45),
                    minimumSize: const Size(160, 60),
                  ),
                  child: const Text('Decline',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

