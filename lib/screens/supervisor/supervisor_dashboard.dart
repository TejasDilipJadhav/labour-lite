import 'package:flutter/material.dart';

class SupervisorDashboard extends StatefulWidget {
  static const String id = 'supervisor_dashboard';

  const SupervisorDashboard({super.key});

  @override
  State<SupervisorDashboard> createState() => _SupervisorDashboardState();
}

class _SupervisorDashboardState extends State<SupervisorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supervisor Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: []),
      ),
    );
  }
}
