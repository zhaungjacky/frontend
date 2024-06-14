import 'package:frontend/pages/auth/bloc/auth_bloc.dart';
import 'package:frontend/pages/users/bloc/users_bloc.dart';
import 'package:frontend/services/auth/data-source/auth_data.dart';
import 'package:frontend/services/auth/repository/auth_repo.dart';
import 'package:frontend/services/storage/storage.dart';
import 'package:frontend/services/users/data/user_data.dart';
import 'package:frontend/services/users/repo/user_repo.dart';
import 'package:get_it/get_it.dart';

GetIt singleton = GetIt.instance;

Future<void> initSingleton() async {
  singleton.registerFactory<SharedModel>(() => SharedModel());
  _initAuth();
  _initAuthBloc();
  _usersInfo();
}

_initAuth() {
  singleton.registerFactory<AuthData>(
    () => AuthDataImpl(),
  );
  singleton.registerFactory<AuthRepo>(
    () => AuthRepoImpl(
      authData: singleton<AuthData>(),
    ),
  );
}

_initAuthBloc() {
  singleton.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      authRepo: singleton<AuthRepo>(),
    ),
  );
}

_usersInfo() {
  singleton.registerFactory<UserData>(
    () => UserDataImpl(),
  );
  singleton.registerFactory<UserRepo>(
    () => UserRepoImpl(
      userData: singleton<UserData>(),
    ),
  );
  singleton.registerLazySingleton<UsersBloc>(
    () => UsersBloc(
      singleton<UserRepo>(),
    ),
  );
}
