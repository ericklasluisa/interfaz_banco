import 'package:flutter/material.dart';
import 'package:interfaz_banco/view/pages/login_form_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance,
                  color: Colors.yellow.shade600,
                  size: 40,
                ),
                const SizedBox(width: 16),
                Text(
                  'BANCO PICHINCHA',
                  style: TextStyle(
                    color: Colors.indigo.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Versión 1.0.0',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Image.asset('assets/login-banco.jpg'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginFormPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 2,
                shadowColor: const Color.fromARGB(255, 116, 116, 116),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      color: Color.fromARGB(255, 157, 157, 157), width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: const EdgeInsets.all(8),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 40,
                    color: Colors.black87,
                  ),
                  Text(
                    "Usuario y \ncontraseña",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
