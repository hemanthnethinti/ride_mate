import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPhone;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> titles = [
    "Name",
    "Phone Number",
    "Email",
    "Gender",
    "Date of Birth",
    "Emergency Contact"
  ];

  final List<IconData> icons = [
    Icons.person_2_outlined,
    Icons.phone_android_outlined,
    Icons.email_outlined,
    Icons.person,
    Icons.calendar_month_outlined,
    Icons.emergency_outlined
  ];

  late List<String> subtitles;

  @override
  void initState() {
    super.initState();
    subtitles = [
      'Arshiya Mohammed',
      '9885911100',
      widget.userEmail,
      "Fwmale",
      "05/05/2005",
      ""
    ];
  }

  void _editField(int index) async {
    String? newValue;

    if (titles[index] == "Gender") {
      newValue = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          String selectedGender = subtitles[index] == "Not specified" ? "Male" : subtitles[index];
          return _genderBottomSheet(selectedGender);
        },
      );
    } else if (titles[index] == "Date of Birth") {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
      );
      newValue = "${picked!.day}/${picked.month}/${picked.year}";
        } else {
      newValue = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        builder: (_) => _editBottomSheet(
          fieldName: titles[index],
          initialValue: subtitles[index],
          isNameField: titles[index] == "Name",
        ),
      );
    }

    if (newValue != null && newValue.isNotEmpty) {
      setState(() {
        subtitles[index] = newValue!;
      });
    }
  }

  Widget _editBottomSheet({required String fieldName, required String initialValue, bool isNameField = false}) {
    final TextEditingController firstCtrl = TextEditingController(text: initialValue);
    final TextEditingController lastCtrl = TextEditingController();

    InputDecoration inputStyle(String label, IconData icon) => InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        );

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Edit $fieldName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          if (isNameField)
            TextField(controller: firstCtrl, decoration: inputStyle("First Name", Icons.person)),

          if (isNameField) const SizedBox(height: 10),

          if (isNameField)
            TextField(controller: lastCtrl, decoration: inputStyle("Last Name", Icons.person)),

          if (!isNameField)
            TextField(controller: firstCtrl, decoration: inputStyle(fieldName, Icons.edit)),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(8), 
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.pop(context, isNameField ? "${firstCtrl.text} ${lastCtrl.text}" : firstCtrl.text);
                },
                child: const Text("Save Changes",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderBottomSheet(String selectedGender) {
    String gender = selectedGender;
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Gender", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButton<String>(
                  value: gender,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: ["Male", "Female", "Other"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => gender = val!),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(8), 
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () => Navigator.pop(context, gender),
                    child: const Text("Save Changes",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt_outlined, size: 25, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Column(
              children: List.generate(titles.length, (index) {
                return ListTile(
                  leading: Icon(icons[index], color: Colors.black),
                  title: Text(titles[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(subtitles[index]),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _editField(index),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
