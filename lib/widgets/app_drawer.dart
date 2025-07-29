import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Nanda Kishore"),
            accountEmail: const Text("8008102507"),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.account_circle, size: 42),
            ),
            decoration: const BoxDecoration(color: Colors.orange),
            otherAccountsPictures: const [
              Icon(Icons.star, color: Colors.white),
              Text("4.00", style: TextStyle(color: Colors.white)),
            ],
          ),
          buildDrawerItem(Icons.help, "Help"),
          buildDrawerItem(Icons.payment, "Payment"),
          buildDrawerItem(Icons.directions_bike, "My Rides"),
          buildDrawerItem(Icons.shield, "Safety"),
          buildDrawerItem(Icons.card_giftcard, "Refer and Earn", subtitle: "Get ₹50"),
          buildDrawerItem(Icons.star_outline, "My Rewards"),
          buildDrawerItem(Icons.local_activity, "Power Pass"),
          buildDrawerItem(Icons.monetization_on_outlined, "Rapido Coins"),
          buildDrawerItem(Icons.notifications, "Notifications"),
          buildDrawerItem(Icons.description, "Claims"),
          buildDrawerItem(Icons.settings, "Settings"),
          const Divider(),

          // 🔴 Sign Out button
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign Out"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
             
            },
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerItem(IconData icon, String title, {String? subtitle}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: () {
        // Optional: Add navigation or actions here
      },
    );
  }
}
