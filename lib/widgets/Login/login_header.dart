import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/logo_azul.png',
            width: 100.0,
            height: 100.0,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Ingresa tu número de teléfono',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Te enviaremos un código de verificación',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
