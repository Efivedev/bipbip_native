import 'package:bipbip/widgets/Login/login_header.dart';
import 'package:flutter/material.dart';

import '../widgets/Login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginHeader(),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
