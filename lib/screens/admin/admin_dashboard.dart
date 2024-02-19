import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  static const String id = 'admin_dashboard';
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
      ),
    );
  }
}
