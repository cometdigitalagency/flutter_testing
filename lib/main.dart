import 'package:flutter/material.dart';
import 'package:flutter_testing/cubit/user_cubit.dart';
import 'package:flutter_testing/user_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DI/configure_dependencies.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Testing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<UserCubit>()..getUsers(),
        child: const UserPage(),
      ),
    );
  }
}

