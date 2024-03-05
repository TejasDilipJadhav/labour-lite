import 'package:flutter/material.dart';

import '../Payment/razorpay_gateway.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hi Admin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the payment page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RazorpayIntegration()),
                );
              },
              child: const Text('Pay User'),
            ),
          ],
        ),
      ),
    );
  }
}

// // Define the PaymentPage widget
// class PaymentPage extends StatelessWidget {
//   const PaymentPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment Page"),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text("This is the payment page"),
//       ),
//     );
//   }
// }
