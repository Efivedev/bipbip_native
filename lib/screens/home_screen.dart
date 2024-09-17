import 'package:bipbip/utils/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
