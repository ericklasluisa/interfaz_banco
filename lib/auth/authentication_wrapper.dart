import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interfaz_banco/view/layout/main_layout.dart';
import 'package:interfaz_banco/view/pages/login_page.dart';
import 'package:provider/provider.dart';
import '../controller/user_controller.dart';
import '../provider/user_provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  final UserController _userController = UserController();

  AuthenticationWrapper({super.key});

  Future<void> _updateUserData(BuildContext context, User firebaseUser) async {
    try {
      final user = await _userController.getUserByEmail(firebaseUser.email!);
      if (user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
      }
    } catch (e) {
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            // Actualizamos los datos del usuario desde la API
            _updateUserData(context, snapshot.data!);
            return MainLayout(user: snapshot.data!);
          } else {
            return const LoginPage();
          }
        });
  }
}
