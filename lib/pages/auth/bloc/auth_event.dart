part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginEvent({
    required this.username,
    required this.password,
  });
}

class AuthLogoutEvent extends AuthEvent {}

class AuthLoadStatusEvent extends AuthEvent {}
