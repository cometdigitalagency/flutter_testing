import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/cubit/user_cubit.dart';
import 'package:flutter_testing/models/user_model.dart';
import 'package:flutter_testing/user_detail_page.dart';
import 'package:flutter_testing/user_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

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

  testWidgets('tap on the first list and navigate to user detail page',
      (tester) async {
    when(mockUserCubit.state).thenReturn(
        UserState(status: UserStateStatus.success, userList: tUserList));
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(ListTile).first);

    await tester.pumpAndSettle();

    expect(find.byType(UserPage), findsNothing);
    expect(find.byType(UserDetailPage), findsOneWidget);
  });
}
