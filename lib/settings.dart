import 'package:flutter/material.dart';
import 'package:ride_mate/profile_screen.dart';


class SettingsPage extends StatefulWidget {
  final String userName;

  const SettingsPage({
    super.key,
    required this.userName,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Settings",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [SizedBox(width: 16), Icon(Icons.settings), SizedBox(width: 16)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                ),
                const SizedBox(width: 12),
                Text(widget.userName,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          sectionTitle("Account Settings"),

          
          buildListTile(Icons.person, "Edit Profile", onTap: () async {
            final updatedName = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(userName: 'Arshiya Mohammed', userEmail: 'arshiyabegam@gmai.com', userPhone: '9885911100',)),
            );
            if (updatedName != null) {
              setState(() {
                
              });
            }
          }),

          buildListTile(Icons.lock, "Change Password"),
          buildListTile(Icons.payment, "Add a Payment Method",
              trailing: const Icon(Icons.add)),

          buildSwitchTile("Push Notifications", pushNotifications, (val) {
            setState(() => pushNotifications = val);
          }),

          const SizedBox(height: 20),
          sectionTitle("More"),
          buildListTile(Icons.info_outline, "About Us"),
          buildListTile(Icons.privacy_tip_outlined, "Privacy Policy"),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget buildListTile(IconData icon, String title, {Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }

  Widget buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 18)),
      value: value,
      activeColor: Colors.orange,
      onChanged: onChanged,
    );
  }
}
