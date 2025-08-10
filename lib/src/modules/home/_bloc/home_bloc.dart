import 'package:bloc/bloc.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/api_service.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_event.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_state.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository = locator();

  HomeBloc() : super(TaskLoading()) {
    on<FetchTaskListEvent>(_onFetchTasks);
    add(FetchTaskListEvent());
  }

  Future<void> _onFetchTasks(
    FetchTaskListEvent event,
    Emitter<HomeState?> emit,
  ) async {
    String? userID = await locator<SecureStorage>().userID;
    if (userID == null) {
      emit(TaskError(error: "کاربر یافت نشد", event));
      return;
    }

    await ApiService().callApi(
      _homeRepository.getUserTasks(userID),
      onLoading: () => emit(TaskLoading()),
      onSuccess: (response) =>
          emit(TaskListLoadedSuccessfully(tasks: response.data ?? [])),
      onError: (error) => emit(TaskError(error: error.toString(), event)),
    );
  }
}
