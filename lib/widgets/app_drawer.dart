import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_mate/ratings_page.dart';
import 'package:ride_mate/profile_screen.dart';
import 'package:ride_mate/settings.dart';
import 'package:ride_mate/help_support.dart';
import 'package:ride_mate/privacy.dart';
import 'package:ride_mate/history.dart';
import 'package:ride_mate/verifications.dart';

class AppDrawer extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPhone;

  const AppDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  double myRating = 0.0; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                    userName: widget.userName,
                                    userEmail: widget.userEmail,
                                    userPhone: widget.userPhone)));
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/images/arshiya.jpg')),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(widget.userEmail, style: const TextStyle(color: Colors.black87, fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 20),
                    InkWell(
                      onTap: () async {
                        final updatedRating = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RatingsPage(userName: widget.userName)),
                        );
                        if (updatedRating != null) {
                          setState(() => myRating = updatedRating);
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "${myRating.toStringAsFixed(2)} My Rating",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

           
            ListTile(
                leading: const Icon(Icons.verified),
                title: const Text('Verifications'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Verifications()))),

            ListTile(
                leading: const Icon(Icons.history),
                title: const Text('History'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RideHistoryPage()))),

            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage(userName: widget.userName)))),

            ListTile(
                leading: const Icon(Icons.help_outlined),
                title: const Text('Help & Support'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportPage()))),

            ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Privacy & Security'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySecurityPage()))),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sign Out"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
