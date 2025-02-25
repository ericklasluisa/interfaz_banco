import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../model/user_model.dart';

class UserController {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final String _baseUrl =
      'http://10.40.16.114:9090'; //!cambiar cuando se haga APK

  Future<User?> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // 1. Registrar usuario en Firebase Auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // 2. Crear objeto usuario para la API
        final newUser = User(
          username: username,
          email: email,
          password: password,
        );

        // 3. Enviar datos a la API
        final response = await http.post(
          Uri.parse('$_baseUrl/users'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(newUser.toJson()),
        );

        if (response.statusCode == 200) {
          // Usuario creado exitosamente
          return User.fromJson(jsonDecode(response.body));
        } else {
          // Si falla la API, eliminar usuario de Firebase
          await userCredential.user?.delete();
          throw Exception(
              'Error al registrar usuario en la API: ${response.body}');
        }
      }
    } catch (e) {
      // Manejar errores específicos de Firebase
      if (e is auth.FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            throw Exception('El correo electrónico ya está registrado');
          case 'weak-password':
            throw Exception('La contraseña es muy débil');
          default:
            throw Exception('Error de autenticación: ${e.message}');
        }
      }
      throw Exception('Error en el registro: $e');
    }
    return null;
  }

  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Autenticar con Firebase
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // 2. Obtener todos los usuarios de la API
        final response = await http.get(
          Uri.parse('$_baseUrl/users'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          // 3. Decodificar la lista de usuarios
          final List<dynamic> usersJson = jsonDecode(response.body);

          // 4. Buscar el usuario por email
          final userJson = usersJson.firstWhere(
            (user) => user['email'] == email,
            orElse: () => null,
          );

          if (userJson != null) {
            return User.fromJson(userJson);
          } else {
            throw Exception('Usuario no encontrado en la base de datos');
          }
        } else {
          throw Exception(
              'Error al obtener datos de usuarios: ${response.body}');
        }
      }
    } catch (e) {
      if (e is auth.FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            throw Exception('Usuario no encontrado');
          case 'wrong-password':
            throw Exception('Contraseña incorrecta');
          default:
            throw Exception('Error de autenticación: ${e.message}');
        }
      }
      throw Exception('Error en el login: $e');
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> usersJson = jsonDecode(response.body);
        final userJson = usersJson.firstWhere(
          (user) => user['email'] == email,
          orElse: () => null,
        );

        if (userJson != null) {
          return User.fromJson(userJson);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener usuario: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Obtener usuario actual de Firebase
  auth.User? getCurrentFirebaseUser() {
    return _firebaseAuth.currentUser;
  }
}
