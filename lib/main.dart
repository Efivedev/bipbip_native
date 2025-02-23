import 'package:bipbip/models/user_model.dart';
import 'package:bipbip/router.dart';
import 'package:bipbip/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/session_manager.dart';

late SessionManager sessionManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  sessionManager = SessionManager(prefs);
  
  // Get initial session data
  final authData = sessionManager.getSession();
  
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => UserModel()..initializeFromAuth(authData)
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BipBip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
