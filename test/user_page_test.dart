import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/cubit/user_cubit.dart';
import 'package:flutter_testing/models/user_model.dart';
import 'package:flutter_testing/user_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'user_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserCubit>()])
void main() {
  late MockUserCubit mockUserCubit;
  setUp(() {
    mockUserCubit = MockUserCubit();
  });

  final tUserList = [
    const User(
        id: 1,
        name: 'name1',
        username: 'username1',
        email: 'email1',
        phone: 'phone1',
        website: 'website1'),
    const User(
        id: 2,
        name: 'name2',
        username: 'username2',
        email: 'email2',
        phone: 'phone2',
        website: 'website2'),
  ];
  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Testing',
      home: BlocProvider<UserCubit>(
        create: (context) => mockUserCubit,
        child: const UserPage(),
      ),
    );
  }

  testWidgets('title is displayed', (WidgetTester tester) async {
    when(mockUserCubit.state)
        .thenReturn(const UserState(status: UserStateStatus.initial));
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('User List'), findsOneWidget);
  });

  testWidgets('Show CircleProgressIndicator when status is [loading]',
      (tester) async {
    when(mockUserCubit.state)
        .thenReturn(const UserState(status: UserStateStatus.loading));
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Show list of users when status is [success]', (tester) async {
    when(mockUserCubit.state).thenReturn(
        UserState(status: UserStateStatus.success, userList: tUserList));
    await tester.pumpWidget(createWidgetUnderTest());

    for (final user in tUserList) {
      expect(find.text('Username: ${user.username}'), findsOneWidget);
      expect(find.text('Email: ${user.email}'), findsOneWidget);
    }
  });

  testWidgets('Show error text and refresh button when status is [failure]',
      (tester) async {
    when(mockUserCubit.state).thenReturn(const UserState(
        status: UserStateStatus.failure, errorMessage: 'Something wrong'));
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Something wrong'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
