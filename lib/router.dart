import 'package:bipbip/models/user_model.dart';
import 'package:bipbip/screens/home_screen.dart';
import 'package:bipbip/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final protectedRoutes = ["home_screen"];

String? checkProtectedRoutes(BuildContext context, String? path) {
  final userModel = Provider.of<UserModel>(context, listen: false);
  final isLoggedIn = userModel.isAuthenticated;

  if (!isLoggedIn && protectedRoutes.contains(path)) {
    return "/login";
  }

  return null;
}

GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      name: "home_screen",
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      redirect: (context, state) => checkProtectedRoutes(context, state.name),
    ),
    GoRoute(path: "/home_screen", redirect: (context, state) => "/"),
    GoRoute(
        path: "/login",
        name: "login_screen",
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        }),
  ],
  initialLocation: "/",
);
