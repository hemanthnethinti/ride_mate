import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Help & Support',style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Welcome to RideMate Help Center",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Need assistance? Browse FAQs or contact our support team for help.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),

          
          const Text("Frequently Asked Questions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildFAQ("How can I join a ride?",
              "Browse rides, send a request, and wait for driver approval."),
          _buildFAQ("Is RideMate safe?",
              "Yes, all users are verified and trips can be shared live."),
          _buildFAQ("How do I contact support?",
              "Use the contact details below or send feedback."),
          _buildFAQ("How can I delete my account?",
              "To delete your account, go to 'Profile' → 'Settings' → 'Delete Account'. "
              "Once confirmed, your data and account will be permanently removed."),

          const SizedBox(height: 20),

         
          const Text("Contact Support",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.deepPurple),
            title: const Text("Email Us"),
            subtitle: const Text("support@ridemate.com"),
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.green),
            title: const Text("Call Us"),
            subtitle: const Text("+91 98765 43210"),
          ),

          const SizedBox(height: 20),

          const Text("Send Feedback",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Write your feedback...",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send,color: Colors.white,),
            label: const Text("Submit",style: TextStyle(color: Colors.white,fontSize: 16),),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50)),
          ),
        ],
      ),
    );
  }

  static Widget _buildFAQ(String q, String a) {
    return ExpansionTile(
      title: Text(q, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(a, style: const TextStyle(fontSize: 16)),
        )
      ],
    );
  }
}