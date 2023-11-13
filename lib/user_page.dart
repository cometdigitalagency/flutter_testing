import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/user_detail_page.dart';

import 'cubit/user_cubit.dart';
import 'models/user_model.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state.status == UserStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == UserStateStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${state.errorMessage}'),
                  const ElevatedButton(onPressed: null, child: Text('Refresh'))
                ],
              ),
            );
          }
          return ListView.builder(
              itemCount: state.userList?.length,
              itemBuilder: (context, index) {
                User? currentUser = state.userList?[index];
                return GestureDetector(
                  onTap: () {
                    if (currentUser != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  UserDetailPage(user: currentUser)));
                    }
                  },
                  child: ListTile(
                    title: Text('Username: ${currentUser?.username}'),
                    subtitle: Text('Email: ${currentUser?.email}'),
                  ),
                );
              });
        }));
  }
}
