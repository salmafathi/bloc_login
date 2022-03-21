import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bloc_login/data/models/user_model.dart';


abstract class AuthState extends Equatable {
  const AuthState([List props = const []]): super();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props =>[];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthGranted extends AuthState {
  final String token;
  final User user;
  AuthGranted(this.token, this.user): super([token, user]);

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'user': user?.toJson(),
    };
  }

  factory AuthGranted.fromMap(Map<String, dynamic> map) {
    return AuthGranted(
      map['token'],
      map['user'] != null ? User.fromJson(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthGranted.fromJson(String source) => AuthGranted.fromMap(json.decode(source));

  @override
  List<Object> get props => [token, user];
}

class AuthDenied extends AuthState {
  final List<String> errors;
  const AuthDenied(this.errors);

  @override
  List<Object> get props => [errors];
}


class RegisterLoading extends AuthState {
  const RegisterLoading();
  @override
  List<Object> get props => [];
}

class RegisterDenied extends AuthState {
  const RegisterDenied();
  @override
  List<Object> get props => [];
}

class RegisterGranted extends AuthState {
  final String email;
  RegisterGranted(this.email): super([email]);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  factory RegisterGranted.fromMap(Map<String, dynamic> map) {
    return RegisterGranted(
      map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterGranted.fromJson(String source) => RegisterGranted.fromMap(json.decode(source));

  @override
  List<Object> get props => [email];
}


class ForgotPasswordLoading extends AuthState {
  const ForgotPasswordLoading();
  @override
  List<Object> get props => [];
}
class ForgotPasswordGranted extends AuthState {
  final int randomNumber;
  ForgotPasswordGranted(this.randomNumber): super([randomNumber]);

  Map<String, dynamic> toMap() {
    return {
      'randomNumber': randomNumber,
    };
  }

  factory ForgotPasswordGranted.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordGranted(
      map['randomNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordGranted.fromJson(String source) => ForgotPasswordGranted.fromMap(json.decode(source));

  @override
  List<Object> get props => [randomNumber];
}
class ForgotPasswordError extends AuthState {
  final String error;
  ForgotPasswordError(this.error): super([error]);

  Map<String, dynamic> toMap() {
    return {
      'error': error,
    };
  }

  factory ForgotPasswordError.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordError(
      map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordError.fromJson(String source) => ForgotPasswordError.fromMap(json.decode(source));

  @override
  List<Object> get props => [error];
}

class UpdatePasswordGranted extends AuthState {
  const UpdatePasswordGranted();
  @override
  List<Object> get props => [];
}
class UpdatePasswordDenied extends AuthState {
  const UpdatePasswordDenied();
  @override
  List<Object> get props => [];
}

