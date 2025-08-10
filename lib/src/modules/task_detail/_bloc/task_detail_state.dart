import 'package:equatable/equatable.dart';

sealed class TaskDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CreateTaskInitialState extends TaskDetailState {}

final class EditTaskInitialState extends TaskDetailState {}
