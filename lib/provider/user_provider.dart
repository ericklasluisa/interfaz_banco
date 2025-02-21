import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  final _controller = StreamController<void>.broadcast();

  // Exponemos el stream para los listeners
  Stream<void> get stream => _controller.stream;

  User? get currentUser {
    developer.log('Getting currentUser: ${_currentUser?.toJson()}');
    return _currentUser;
  }

  void setUser(User? user) {
    developer.log('Setting user: ${user?.toJson()}');
    _currentUser = user;
    _controller.add(null); // Notificamos a través del stream
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    _controller.add(null); // Notificamos a través del stream
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
