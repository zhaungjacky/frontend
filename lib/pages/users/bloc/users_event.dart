part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {
  const UsersEvent();
}

class UsersLoadingEvent extends UsersEvent {}
