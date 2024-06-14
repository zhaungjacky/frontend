import 'package:bloc/bloc.dart';
import 'package:frontend/services/models/user_info.dart';
import 'package:frontend/services/users/repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepo _userRepo;
  UsersBloc(UserRepo userRepo)
      : _userRepo = userRepo,
        super(UsersInitial()) {
    on<UsersEvent>(
      (_, emit) => emit(
        UsersInitial(),
      ),
    );
    on<UsersLoadingEvent>(_loading);
  }

  _loading(UsersLoadingEvent event, Emitter emit) async {
    try {
      final res = await _userRepo.getUserLists();
      if (res != null) {
        emit(
          UsersSuccessState(usersinfo: res),
        );
      } else {
        emit(
          UsersFailureState(),
        );
      }
    } catch (err) {
      emit(
        UsersErrorState(
          error: err.toString(),
        ),
      );
    }
  }
}
