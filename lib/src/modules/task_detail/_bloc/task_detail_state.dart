import 'package:equatable/equatable.dart';

sealed class TaskDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CreateTaskInitialState extends TaskDetailState {}

final class EditTaskInitialState extends TaskDetailState {}

final class TaskLoadingState extends TaskDetailState {}

final class TaskSuccessState extends TaskDetailState {}

final class TaskFailureState extends TaskDetailState {
  final String error;

  TaskFailureState({required this.error});
}
