sealed class HomeEvent {}

class FetchTaskListEvent extends HomeEvent {}

class DeleteTaskEvent extends HomeEvent {
  final int taskID;

  DeleteTaskEvent(this.taskID);
}
