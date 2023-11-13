import 'package:flutter/material.dart';
import 'package:flutter_testing/user_detail_tile.dart';

import 'models/user_model.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(user.username[0]),
              ),
              UserDetailTile(
                title: 'Username',
                detail: user.username,
              ),
              UserDetailTile(
                title: 'Name',
                detail: user.name,
              ),
              UserDetailTile(
                title: 'Email',
                detail: user.email,
              ),
              UserDetailTile(
                title: 'Phone',
                detail: user.phone,
              ),
              UserDetailTile(
                title: 'Website',
                detail: user.website,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
