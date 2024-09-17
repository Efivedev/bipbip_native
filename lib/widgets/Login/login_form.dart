import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../utils/color.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key = const Key('login_form')}) : super(key: key);

  void _login(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    userModel.setIsLogged(true);
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) => _login(context),
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
              onPressed: () => _login(context),
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
}
