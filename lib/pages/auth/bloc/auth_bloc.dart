import 'package:bloc/bloc.dart';
import 'package:frontend/services/auth/repository/auth_repo.dart';
import 'package:frontend/services/singleton/singleton.dart';
import 'package:frontend/services/storage/storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => AuthInitial());
    on<AuthLoadStatusEvent>(_initAuthStatus);
    on<AuthLoginEvent>(_login);
    on<AuthLogoutEvent>(_logout);
  }

  _initAuthStatus(AuthLoadStatusEvent event, Emitter emit) async {
    try {
      final res =
          await singleton<SharedModel>().getItem(SharedModel.accessKey());
      // print(res);
      if (res != null) {
        final isExpired = JwtDecoder.isExpired(res);
        // print(isExpired);
        if (isExpired) {
          emit(const AuthFailureOrErrorState(
            message: 'Token expored, please login again',
          ));
        } else {
          emit(AuthSuccessState());
        }
      }
    } catch (error) {
      emit(AuthFailureOrErrorState(message: error.toString()));
    }
  }

  _login(AuthLoginEvent event, Emitter emit) async {
    try {
      final res = await _authRepo.login(
        username: event.username,
        password: event.password,
      );
      if (res != null && res.access!.isNotEmpty) {
        emit(AuthSuccessState());
      } else {
        emit(const AuthFailureOrErrorState(
          message: 'Invalid Username Or Password',
        ));
      }
    } catch (err) {
      emit(AuthFailureOrErrorState(
        message: err.toString(),
      ));
    }
  }

  _logout(AuthLogoutEvent event, Emitter emit) async {
    try {
      await _authRepo.logout();
      emit(const AuthFailureOrErrorState(
        message: "Logout success",
      ));
    } catch (err) {
      emit(AuthFailureOrErrorState(message: err.toString()));
    }
  }

  // @override
  // Future<void> close() async{
  //   super.close();

  // }
}
