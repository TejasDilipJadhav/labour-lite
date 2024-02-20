import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labour_lite/screens/admin/admin_dashboard.dart';
import 'package:labour_lite/screens/login_screen.dart';
import 'package:labour_lite/screens/registration_screen.dart';
import 'package:labour_lite/screens/supervisor/supervisor_dashboard.dart';
import 'package:labour_lite/screens/user/personal_details_screen.dart';
import 'package:labour_lite/screens/user/upload_screen.dart';
import 'package:labour_lite/screens/user/user_dashboard.dart';
import 'package:labour_lite/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: (const FirebaseOptions(
          apiKey: 'AIzaSyDalUB9519fyPlV1S3ybDjws7KpNHnCKZA',
          appId: "1:1005571767606:android:17fccb38a9f2b12b6bc797",
          messagingSenderId: '1005571767606',
          projectId: "labour-lite",
          storageBucket: "labour-lite.appspot.com",
        )))
      : Firebase.initializeApp();
  runApp(const LabourLite());
}

class LabourLite extends StatelessWidget {
  const LabourLite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        UserDashboard.id: (context) => const UserDashboard(),
        SupervisorDashboard.id: (context) => const SupervisorDashboard(),
        AdminDashboard.id: (context) => const AdminDashboard(),
        UploadScreen.id: (context) => UploadScreen(),
        PersonalDetailsScreen.id: (context) => const PersonalDetailsScreen(),
      },
    );
  }
}
