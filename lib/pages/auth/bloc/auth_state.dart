part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthProcessingState extends AuthState {
  final String username;
  final String password;

  const AuthProcessingState({
    required this.username,
    required this.password,
  });
}

final class AuthSuccessState extends AuthState {}

final class AuthFailureState extends AuthState {}

// final class AuthErrorState extends AuthState {
//   final String error;

//   const AuthErrorState({required this.error});
// }
