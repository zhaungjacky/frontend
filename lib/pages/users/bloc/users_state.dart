part of 'users_bloc.dart';

@immutable
sealed class UsersState {
  const UsersState();
}

final class UsersInitial extends UsersState {}

final class UsersSuccessState extends UsersState {
  final List<UserInfo> usersinfo;

  const UsersSuccessState({
    required this.usersinfo,
  });
}

final class UsersFailureState extends UsersState {}

final class UsersErrorState extends UsersState {
  final String error;

  const UsersErrorState({required this.error});
}
