import 'package:bipbip/models/user_model.dart';
import 'package:bipbip/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final userModel = Provider.of<UserModel>(context, listen: false);

    if (!userModel.isLogged) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), backgroundColor: AppColors.primary),
        ),
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
