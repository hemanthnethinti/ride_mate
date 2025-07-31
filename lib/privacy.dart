import 'package:flutter/material.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: const Text('Privacy & Security',style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
            
              Text(
                "We respect your privacy and prioritize your safety while using RideMate. "
                "This page outlines how we handle your data and the safety measures we implement to ensure a secure travel experience.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              Text("1. Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 6),
              Text(
                "• We collect only necessary data (name, phone, email, ride details).\n"
                "• Location data is used only for trip navigation and safety.\n"
                "• Your data is not shared with third parties without your consent.\n"
                "• You can request deletion of your data anytime.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              Text("2. Data Protection",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 6),
              Text(
                "We store your data securely using encryption and protect it from unauthorized access.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              Text("3. Security & Safety Measures",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 6),
              Text(
                "• All users must verify their identity to ensure trust.\n"
                "• Real-time location sharing is available for safe travel.\n"
                "• An SOS button is provided for emergencies.\n"
                "• You can report suspicious activities anytime.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              Text("4. Your Responsibilities",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 6),
              Text(
                "• Verify driver/rider profiles before travel.\n"
                "• Follow community guidelines for respectful interactions.\n"
                "• Use the app’s safety features to stay protected.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              Text("5. Contact Us",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 6),
              Text(
                "For any privacy or security concerns, contact our support team at:\n"
                "📧 support@ridemate.com\n"
                "📞 +91 98765 43210",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}