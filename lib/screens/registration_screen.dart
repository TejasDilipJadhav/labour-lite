import 'package:flutter/material.dart';
import 'package:labour_lite/screens/supervisor/supervisor_dashboard.dart';
import 'package:labour_lite/screens/user/user_dashboard.dart';
import 'package:labour_lite/screens/welcome_screen.dart';
import 'package:labour_lite/services/authentication.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'admin/admin_dashboard.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  late String password;
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200,
                  child: Image.asset('assets/worker_logo.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              myTextField(
                hintText: "Enter your email",
                hide: false,
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              myTextField(
                hintText: "Enter your password",
                hide: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              myOptionButton(
                  title: 'Register',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    MyAuthentication myAuthentication = MyAuthentication();
                    MyUser myUser = await myAuthentication.register(
                        email: email, password: password);
                    if (myUser == MyUser.user) {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, UserDashboard.id);
                    } else if (myUser == MyUser.supervisor) {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, SupervisorDashboard.id);
                    } else if (myUser == MyUser.admin) {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, AdminDashboard.id);
                    } else {
                      setState(() {
                        showSpinner = false;
                      });
                      showDialog(
                          context: context,
                          builder: (context) {
                            return myFailedDialog(context);
                          });
                    }
                  })
            ]),
      ),
    );
  }
}

Padding myTextField(
    {required Function onChanged,
    required bool hide,
    required String hintText}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      onChanged: (value) {
        onChanged(value);
      },
      obscureText: hide,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    ),
  );
}

AlertDialog myFailedDialog(BuildContext context) {
  return AlertDialog(
    title: const Text(
      "Error",
      textAlign: TextAlign.center,
    ),
    actions: [
      Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
          child: const Text("CLOSE"),
        ),
      )
    ],
  );
}
