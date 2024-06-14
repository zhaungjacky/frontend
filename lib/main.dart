import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/pages/auth/bloc/auth_bloc.dart';
import 'package:frontend/pages/users/bloc/users_bloc.dart';
import 'package:frontend/services/router/my_router.dart';
import 'package:frontend/services/singleton/singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingleton();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => singleton<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<UsersBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Frontend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: myRouter(),
    );
  }
}
