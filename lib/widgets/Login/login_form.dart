import 'package:bipbip/models/user_model.dart';
import 'package:bipbip/services/auth_service.dart';
import 'package:bipbip/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/color.dart';
import 'verification_code_dialog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) => _handleSubmit(context, value),
              decoration: const InputDecoration(
                  hintText: 'Número de celular',
                  labelText: 'N° de Celular',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  )),
              autofocus: true,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _handleSubmit(context, _phoneController.text),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: AppColors.primary,
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVerificationDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return VerificationCodeDialog(
          phoneNumber: phoneNumber,
          onVerificationComplete: (code) {
            Navigator.of(context).pop(); // Close dialog
            // Handle verification here
            _handleVerification(context, phoneNumber, code);
          },
        );
      },
    );
  }

  // In your form submission method
  final _authService = AuthService();

  Future<void> _handleSubmit(BuildContext context, String phoneNumber) async {
    if (phoneNumber.isNotEmpty && phoneNumber.length == 9) {
      try {
        //final success = await _authService.requestVerification(phoneNumber);
        const success = true;
        if (success) {
          _showVerificationDialog(context, phoneNumber);
        }
      } catch (e) {
        print("Error: $e");
        ToastUtils.showError("Error al enviar el código");
      }
      return;
    }
    ToastUtils.showError("Número de celular inválido");
  }

  Future<void> _handleVerification(BuildContext context, String phone, String code) async {
    try {
      final authResponse = await _authService.verifyCode(phone, code);
      
      // Update user session
      final userModel = Provider.of<UserModel>(context, listen: false);
      await userModel.setSession(authResponse);
      
      // Navigate to home screen
      Navigator.of(context).pushReplacementNamed("home_screen");
    } catch (e) {
      print("Error en _handleVerification: $e");
      ToastUtils.showError("Código inválido");
    }
  }
}
