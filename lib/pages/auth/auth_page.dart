import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/pages/auth/bloc/auth_bloc.dart';
import 'package:frontend/pages/auth/login_page.dart';
import 'package:frontend/pages/users/users_page.dart';
import 'package:frontend/services/singleton/singleton.dart';
import 'package:frontend/services/storage/storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  static String routerPath() => "/";

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? access;

  @override
  void initState() {
    super.initState();
    getAccess();
  }

  Future<String?> getAccess() async {
    final res = await singleton<SharedModel>().getItem(SharedModel.accessKey());
    // print(res);
    if (res != null) {
      final isExpired = JwtDecoder.isExpired(res);
      // print(isExpired);
      if (isExpired) return null;
      setState(() {
        access = res;
        context.read<AuthBloc>().add(
              AuthLoadStatusEvent(),
            );
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthInitial():
            return const LoginPage();
          case AuthProcessingState():
            return const CircularProgressIndicator();
          case AuthSuccessState():
            return const UsersPage();
          case AuthFailureState():
            return const LoginPage();
        }
      },
    );
  }
}
