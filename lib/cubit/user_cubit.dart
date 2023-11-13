import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';
import '../services/rest_client.dart';

part 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this.restClient) : super(const UserState());
  final RestClient restClient;

  Future<void> getUsers() async {
    emit(state.copyWith(status: UserStateStatus.loading));
    try {
      final result = await restClient.getUserList();
      emit(state.copyWith(status: UserStateStatus.success, userList: result));
    } catch (e) {
      emit(state.copyWith(
          status: UserStateStatus.failure, errorMessage: 'Something wrong'));
    }
  }
}
