import 'package:flutter/material.dart';

class SupervisorDashboard extends StatelessWidget {
  static const String id = 'supervisor_dashboard';
  const SupervisorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supervisor Dashboard"),
        centerTitle: true,
      ),
    );
  }
}
