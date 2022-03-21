part of 'auth_shared_bloc.dart';

abstract class AuthSharedEvent extends Equatable {
  const AuthSharedEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class AuthSharedInit extends AuthSharedEvent {}

class AuthSharedLoginRequested extends AuthSharedEvent {
  const AuthSharedLoginRequested(this.email, this.password, this.device);
  final String email;
  final String password;
  final String device;

  @override
  List<Object> get props => [email, password, device];
}

class AuthSharedRegisterRequested extends AuthSharedEvent {
  const AuthSharedRegisterRequested(this.email, this.password, this.cpassword);
  final String email;
  final String password;
  final String cpassword;

  @override
  List<Object> get props => [email, password, cpassword];
}

class AuthRefreshRequested extends AuthSharedEvent {
  const AuthRefreshRequested(this.token, this.device, this.user);
  final String token;
  final String device;
  final User user;

  @override
  List<Object> get props => [token, device, user != null];
}

class AuthLogoutRequested extends AuthSharedEvent {
  const AuthLogoutRequested(this.token);
  final String token;

  @override
  List<Object> get props => [token];
}

class AuthForgotPasswordRequested extends AuthSharedEvent {
  const AuthForgotPasswordRequested(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class UpdatePasswordRequested extends AuthSharedEvent {
  const UpdatePasswordRequested(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class Authenticated extends AuthSharedEvent {
  const Authenticated(this.token, this.user);
  final String token;
  final User user;

  @override
  List<Object> get props => [token, user != null];
}