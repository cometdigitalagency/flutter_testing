import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/models/user_model.dart';
import 'package:flutter_testing/user_detail_page.dart';

void main() {
  const userDetail = User(
      id: 1,
      name: 'name',
      username: 'username',
      email: 'email',
      phone: 'phone',
      website: 'website');

  testWidgets('title is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: UserDetailPage(user: userDetail),
    ));
    expect(find.text('User detail'), findsOneWidget);
  });
  testWidgets('UserDetailPage should display all fields of user detail',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: UserDetailPage(user: userDetail),
    ));

    final expectedText = <String>[
      userDetail.username,
      userDetail.name,
      userDetail.email,
      userDetail.phone,
      userDetail.website,
    ];

    expect(find.byType(CircleAvatar), findsOneWidget);

    for (final text in expectedText) {
      expect(find.text(text), findsOneWidget);
    }
  });
}
