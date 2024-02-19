import 'package:flutter/material.dart';
import 'package:labour_lite/screens/user/upload_screen.dart';

class UserDashboard extends StatelessWidget {
  static const String id = 'user_dashboard';
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          myUpload(
              onPressed: () {
                Navigator.pushNamed(context, UploadScreen.id);
              },
              text: "Upload Documents",
              icon: Icons.upload),
          myUpload(
              onPressed: () {},
              text: "Personal Details",
              icon: Icons.assignment_ind),
          myUpload(
              onPressed: () {},
              text: "Bank Details",
              icon: Icons.currency_rupee),
        ],
      ),
    );
  }
}

Flexible myUpload(
    {required Function onPressed,
    required String text,
    required IconData icon}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    ),
  );
}
