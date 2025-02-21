import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interfaz_banco/view/pages/register_page.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  iniciarSesionFirebase() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _userController.text,
        password: _passwordController.text,
      );
      if (!mounted) return; // Verificar si el widget sigue montado
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return; // Verificar si el widget sigue montado
      switch (e.code) {
        case 'user-not-found':
          _mostrarError('No existe una cuenta con este correo electrónico');
          break;
        case 'wrong-password':
          _mostrarError('Credenciales incorrectas');
          break;
        case 'invalid-email':
          _mostrarError('El formato del correo electrónico no es válido');
          break;
        case 'user-disabled':
          _mostrarError('Esta cuenta ha sido deshabilitada');
          break;
        default:
          _mostrarError('Error al iniciar sesión: ${e.message}');
      }
    } catch (e) {
      if (!mounted) return; // Verificar si el widget sigue montado
      _mostrarError('Ocurrió un error inesperado');
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.account_balance,
              color: Colors.yellow.shade600,
              size: 40,
            ),
            const SizedBox(width: 16),
            Text(
              'BANCO\nPICHINCHA',
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Ingresa con tu usuario y contraseña de Banca Web',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: _userController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person_outline, color: Colors.black),
                        border: InputBorder.none,
                        hintText: 'Usuario',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: _passwordController,
                      obscureText:
                          true, // Agregar esto para ocultar la contraseña
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock_outline, color: Colors.black),
                        border: InputBorder.none,
                        hintText: 'Contraseña',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 32,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: iniciarSesionFirebase,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.yellow.shade600,
                    disabledBackgroundColor: Colors.yellow.shade100,
                    foregroundColor: Colors.blue.shade900,
                  ),
                  child: const Text('Iniciar Sesión',
                      style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
