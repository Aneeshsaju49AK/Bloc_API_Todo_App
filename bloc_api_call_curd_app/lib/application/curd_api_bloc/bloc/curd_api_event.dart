part of 'curd_api_bloc.dart';

@immutable
sealed class CurdApiEvent {}

class PostUser extends CurdApiEvent {
  final String title;
  final String description;
  final bool isCompleted;
  final BuildContext context;

  PostUser({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.context,
  });
}

class ReadEvent extends CurdApiEvent {}

class DeleteUserEvent extends CurdApiEvent {
  final String id;
  BuildContext context;
  DeleteUserEvent({required this.id, required this.context});
}

class UpdateUser extends CurdApiEvent {
  final String id;
  final String title;
  final String description;
  final BuildContext context;
  final bool isCompleted;

  UpdateUser({
    required this.id,
    required this.title,
    required this.description,
    required this.context,
    required this.isCompleted,
  });
}
