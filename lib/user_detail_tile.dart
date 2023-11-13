import 'package:flutter/material.dart';

class UserDetailTile extends StatelessWidget {
  const UserDetailTile({super.key, required this.title, required this.detail});

  final String title, detail;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.purple[300]),
      ),
      subtitle: Text(detail),
    );
  }
}
