import 'dart:io';

enum AuthMode { Singup, Login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.Login;

  bool get isLogin => _mode == AuthMode.Login;
  bool get isSingup => _mode == AuthMode.Singup;

  void toggleAuthMode() => _mode = isLogin ? AuthMode.Singup : AuthMode.Login;
}
