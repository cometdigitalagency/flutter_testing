part of 'user_cubit.dart';

enum UserStateStatus { initial, loading, success, failure }

class UserState extends Equatable {
  final UserStateStatus status;
  final List<User>? userList;
  final String? errorMessage;

  const UserState(
      {this.status = UserStateStatus.initial,
      this.userList,
      this.errorMessage});

  UserState copyWith(
      {UserStateStatus? status, List<User>? userList, String? errorMessage}) {
    return UserState(
        status: status ?? this.status,
        userList: userList ?? this.userList,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, userList, errorMessage];
}
