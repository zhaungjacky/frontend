import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/pages/auth/bloc/auth_bloc.dart';
import 'package:frontend/services/utils/get_username_localstorage.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //get usrename from localstorage
    ininUsername();
  }

  Future<void> ininUsername() async {
    try {
      final res = await getUsernameFromLocalstorage();
      if (res != null) {
        setState(() {
          _usernameController.text = res;
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        elevation: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: "username"),
              ),
              const Gap(30),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: "password"),
                obscureText: true,
              ),
              const Gap(30),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthLoginEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ),
                        );
                    // await singleton<AuthRepo>().isAuth(
                    //   username: _usernameController.text,
                    //   password: _passwordController.text,
                    // );
                  },
                  child: const Text("Login")),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
