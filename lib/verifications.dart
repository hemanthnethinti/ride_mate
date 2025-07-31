import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Verifications extends StatefulWidget {
  const Verifications({super.key});

  @override
  State<Verifications> createState() => _VerificationsState();
}

class _VerificationsState extends State<Verifications> {
  File? aadhaarFile, licenseFile, selfieFile;
  String? aadhaarPath, licensePath, selfiePath;

  String kycStatus = "Not Submitted";
  final picker = ImagePicker();

  Color get statusColor {
    switch (kycStatus) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      case "Pending":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (kycStatus) {
      case "Approved":
        return Icons.check_circle;
      case "Rejected":
        return Icons.cancel;
      case "Pending":
        return Icons.hourglass_top;
      default:
        return Icons.upload_file;
    }
  }

  Future<void> pickImage(String type) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (kIsWeb) {
          if (type == "aadhaar") aadhaarPath = picked.path;
          if (type == "license") licensePath = picked.path;
          if (type == "selfie") selfiePath = picked.path;
        } else {
          if (type == "aadhaar") aadhaarFile = File(picked.path);
          if (type == "license") licenseFile = File(picked.path);
          if (type == "selfie") selfieFile = File(picked.path);
        }
      });
    }
  }

  Widget filePreview(File? file, {String? webPath}) {
    if (kIsWeb && webPath != null) {
      return Image.network(webPath, height: 80, width: 80, fit: BoxFit.cover);
    } else if (!kIsWeb && file != null) {
      return Image.file(file, height: 80, width: 80, fit: BoxFit.cover);
    } else {
      return const Icon(Icons.insert_drive_file, size: 50, color: Colors.grey);
    }
  }

  void submitKyc() {
    setState(() => kycStatus = "Pending");

    Future.delayed(const Duration(seconds: 3), () {
      setState(() =>
          kycStatus = DateTime.now().second % 2 == 0 ? "Approved" : "Rejected");
    });
  }

 
  Widget orangeButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      height: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: const TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Verifications",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor, width: 2),
            ),
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Icon(statusIcon,
                      key: ValueKey(kycStatus),
                      size: 60,
                      color: statusColor),
                ),
                const SizedBox(height: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text("KYC Status: $kycStatus",
                      key: ValueKey(kycStatus),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: statusColor)),
                ),
                if (kycStatus == "Pending") ...[
                  const SizedBox(height: 8),
                  const CircularProgressIndicator(color: Colors.orange)
                ]
              ],
            ),
          ),

          const Divider(height: 30),
          const Text("Upload Required Documents",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),

         
          Row(children: [
            filePreview(aadhaarFile, webPath: aadhaarPath),
            const SizedBox(width: 10),
            orangeButton("Upload Aadhaar", () => pickImage("aadhaar"))
          ]),
          const SizedBox(height: 15),

          Row(children: [
            filePreview(licenseFile, webPath: licensePath),
            const SizedBox(width: 10),
            orangeButton("Upload License", () => pickImage("license"))
          ]),
          const SizedBox(height: 15),

          
          Row(children: [
            filePreview(selfieFile, webPath: selfiePath),
            const SizedBox(width: 10),
            orangeButton("Upload Selfie", () => pickImage("selfie"))
          ]),

          const Spacer(),

          
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: ElevatedButton.icon(
              key: ValueKey(kycStatus),
              icon: Icon(statusIcon, color: Colors.white),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size.fromHeight(50)),
              onPressed: submitKyc,
              label: Text(
                  kycStatus == "Not Submitted"
                      ? "Submit KYC"
                      : (kycStatus == "Pending"
                          ? "Verifying..."
                          : "Resubmit KYC"),
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
        ]),
      ),
    );
  }
}
