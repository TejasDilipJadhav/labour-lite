import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:labour_lite/screens/login_screen.dart';
import 'package:labour_lite/screens/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 60,
                      child: Image.asset('assets/worker_logo.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText('Labour Lite',
                          speed: const Duration(milliseconds: 200),
                          textStyle: const TextStyle(
                              fontSize: 45, fontWeight: FontWeight.w900))
                    ],
                  ),
                ],
              ),
              myOptionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  title: "Login"),
              myOptionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  title: "Register"),
            ],
          ),
        ),
      ),
    );
  }
}

Padding myOptionButton({required String title, required Function onPressed}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Text(title),
    ),
  );
}
