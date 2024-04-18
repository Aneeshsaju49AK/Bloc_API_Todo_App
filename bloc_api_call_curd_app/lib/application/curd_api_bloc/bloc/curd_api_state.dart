part of 'curd_api_bloc.dart';

@immutable
sealed class CurdApiState {}

class CurdApiInitial extends CurdApiState {}

class CurdErrorState extends CurdApiState {
  final String error;
  CurdErrorState({required this.error});
}

class CurdLoadingState extends CurdApiState {}

class PostUserLoading extends CurdApiState {
  bool isLoading;
  PostUserLoading({required this.isLoading});
}

class ReadUserState extends CurdApiState {
  final UserModel userModel;
  ReadUserState({required this.userModel});
}

class UpdateLoading extends CurdApiState {
  bool isLoading;
  UpdateLoading({required this.isLoading});
}

class DeleteInitial extends CurdApiState {
  bool isLoading;
  DeleteInitial({required this.isLoading});
}

class DeleteLoaded extends CurdApiState {}
