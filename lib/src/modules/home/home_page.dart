import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ofoq_kourosh_assessment/src/components/api_response_handler_widget.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/helper/error_handler.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_bloc.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_state.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_components/task_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget with ErrorHandler {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست تسک ها', style: context.textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is DeleteTaskSuccessfullyState) {
            showSuccessMessage(context, 'تسک موردنظر حذف شد');
          }
        },
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskErrorState) {
            return DefaultErrorWidget(
              onRetryTapped: () =>
                  context.read<HomeBloc>().add(state.retryEvent),
            );
          } else if (state is TaskListLoadedSuccessfullyState) {
            if (state.tasks.isEmpty) {
              return Center(
                child: Text(
                  'تسکی برای شما یافت نشد',
                  style: context.textTheme.titleLarge,
                ),
              );
            } else {
              return ListView.separated(
                itemCount: state.tasks.length,
                separatorBuilder: (context, index) => Gap(8),
                itemBuilder: (_, index) =>
                    TaskListItem(task: state.tasks[index]),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
