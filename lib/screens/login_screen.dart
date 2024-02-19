import 'package:flutter/material.dart';
import 'package:labour_lite/screens/admin/admin_dashboard.dart';
import 'package:labour_lite/screens/registration_screen.dart';
import 'package:labour_lite/screens/supervisor/supervisor_dashboard.dart';
import 'package:labour_lite/screens/user/user_dashboard.dart';
import 'package:labour_lite/screens/welcome_screen.dart';
import 'package:labour_lite/services/authentication.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  title: 'Login',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    MyAuthentication myAuthentication = MyAuthentication();
                    MyUser myUser = await myAuthentication.login(
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
