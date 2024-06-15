import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/pages/auth/bloc/auth_bloc.dart';
import 'package:frontend/pages/users/bloc/users_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(UsersLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
        elevation: 120,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    AuthLogoutEvent(),
                  );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: const SafeArea(
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.message,
                  size: 100,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              switch (state) {
                case UsersInitial():
                  return const CircularProgressIndicator();
                case UsersSuccessState():
                  final lists = state.usersinfo;
                  return ListView.builder(
                      itemCount: lists.length,
                      itemBuilder: (context, index) {
                        final item = lists[index];
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text(item.email),
                        );
                      });
                case UsersFailureState():
                  return const Text("Fetch data failure");
                case UsersErrorState():
                  return Text(state.error);
              }
            },
          ),
        ),
      ),
    );
  }
}
