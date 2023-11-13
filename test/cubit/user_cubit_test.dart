import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/cubit/user_cubit.dart';
import 'package:flutter_testing/models/user_model.dart';
import 'package:flutter_testing/services/rest_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'user_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RestClient>()])
void main() {
  late UserCubit userCubit;
  late MockRestClient mockRestClient;

  setUp(() {
    mockRestClient = MockRestClient();
    userCubit = UserCubit(mockRestClient);
  });

  test(
      'initial status should be [initial], userList and errorMessage should be [null]',
      () {
    expect(
        userCubit.state,
        const UserState(
            status: UserStateStatus.initial,
            userList: null,
            errorMessage: null));
  });

  group('GetUsers', () {
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
    test(
      'should get user list from restclient',
      () async {
        // arrange
        when(mockRestClient.getUserList()).thenAnswer((_) async => tUserList);
        // act
        await userCubit.getUsers();
        // assert
        expect(userCubit.state.userList, tUserList);
        verify(mockRestClient.getUserList());
      },
    );

    test('emits [loading, success] states when receive data', () async {
      when(mockRestClient.getUserList()).thenAnswer((_) async => tUserList);
      expectLater(
        userCubit.stream,
        emitsInOrder([
          const UserState(status: UserStateStatus.loading),
          UserState(status: UserStateStatus.success, userList: tUserList),
        ]),
      );
      await userCubit.getUsers();
    });

    test('emits [loading, failure] states when receive error', () async {
      when(mockRestClient.getUserList()).thenThrow(Exception());
      expectLater(
          userCubit.stream,
          emitsInOrder([
            const UserState(status: UserStateStatus.loading),
            const UserState(
                status: UserStateStatus.failure,
                errorMessage: 'Something wrong'),
          ]));
      userCubit.getUsers();
    });
  });
}
