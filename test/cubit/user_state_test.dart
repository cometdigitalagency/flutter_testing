import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/cubit/user_cubit.dart';
import 'package:flutter_testing/models/user_model.dart';

void main() {
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

  test('copyWith should return UserState instance with updated values', () {
    const initialUserState = UserState(status: UserStateStatus.initial);
    const updatedUserStateStatus = UserStateStatus.success;
    final updatedUserList = tUserList;
    final newUserState = initialUserState.copyWith(
        status: updatedUserStateStatus, userList: updatedUserList);
    expect(newUserState.status, equals(updatedUserStateStatus));
    expect(newUserState.userList, equals(updatedUserList));
  });
}
