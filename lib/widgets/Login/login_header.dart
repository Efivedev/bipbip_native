import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/icon.png',
            width: 120.0,
            height: 120.0,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Ingresa tu número de teléfono',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Te enviaremos un código de verificación',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
