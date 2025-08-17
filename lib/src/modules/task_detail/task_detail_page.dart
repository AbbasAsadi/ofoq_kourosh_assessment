import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/components/app_text_field.dart';
import 'package:ofoq_kourosh_assessment/src/components/map_widget.dart';
import 'package:ofoq_kourosh_assessment/src/components/submit_button.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';
import 'package:ofoq_kourosh_assessment/src/helper/app_validator.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/helper/error_handler.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_bloc.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_event.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_state.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/entity/task_params.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key, this.task});

  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskDetailBloc(
        task == null ? CreateTaskInitialState() : EditTaskInitialState(),
      ),
      child: _TaskDetailPage(task),
    );
  }
}

class _TaskDetailPage extends StatefulWidget {
  const _TaskDetailPage(this.task);

  final TaskModel? task;

  @override
  State<_TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<_TaskDetailPage> with ErrorHandler {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController taskTitleTextController = TextEditingController();
  final TextEditingController taskDescriptionTextController =
      TextEditingController();

  LatLng? selectedPointer;

  @override
  void initState() {
    if (widget.task != null) {
      taskTitleTextController.text = widget.task?.taskName ?? '';
      taskDescriptionTextController.text = widget.task?.taskDesc ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    taskTitleTextController.dispose();
    taskDescriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailBloc, TaskDetailState>(
      listener: (context, state) {
        if (state is TaskSuccessState) {
          showSuccessMessage(
            context,
            widget.task == null
                ? 'تسک موردنظر با موفقیت ساخته شد'
                : 'تسک موردنظر با موفقیت ویرایش شد',
          );
          Future.delayed(Duration(milliseconds: 1500), () => context.pop(true));
        } else if (state is TaskFailureState) {
          showError(context: context, message: 'خطایی حین عملیات رخ داد');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.task == null ? 'تسک جدید' : 'ویرایش تسک',
            style: context.textTheme.bodyLarge,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('عنوان:', style: context.textTheme.labelMedium),
                    Gap(8),
                    AppTextField(
                      controller: taskTitleTextController,
                      hintText: "عنوان",
                      validator: AppValidator.globalValidator,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                    ),
                    Gap(16),
                    Text('توضیحات:', style: context.textTheme.labelMedium),
                    Gap(8),
                    AppTextField(
                      controller: taskDescriptionTextController,
                      hintText: "توضیحات",
                      maxLines: 5,
                      validator: AppValidator.globalValidator,
                    ),
                  ],
                ),
              ),
            ),
            Gap(32),
            Expanded(
              child: Stack(
                children: [
                  MapWidget(
                    initialPoint: LatLng(
                      double.tryParse(widget.task?.lat ?? '') ?? 35.731072,
                      double.tryParse(widget.task?.lng ?? '') ?? 51.419256,
                    ),
                    fetchLocationButtonBottomPadding: 90,
                    onSelectNewLocation: (value) {
                      selectedPointer = value;
                    },
                  ),
                  Positioned(
                    right: 24,
                    left: 24,
                    bottom: 24,
                    child: BlocSelector<TaskDetailBloc, TaskDetailState, bool>(
                      selector: (state) => (state is TaskLoadingState),
                      builder: (context, isLoading) {
                        return SubmitButton(
                          onTap: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              String title = taskTitleTextController.text;
                              String description =
                                  taskDescriptionTextController.text;
                              String? userID =
                                  await locator<SecureStorage>().userID;

                              final task = TaskParams(
                                id: widget.task?.id,
                                isDone: widget.task?.isDone,
                                taskName: title,
                                taskDesc: description,
                                userId: userID,
                                lat:
                                    selectedPointer?.latitude.toString() ??
                                    widget.task?.lat ??
                                    "35.54654231",
                                lng:
                                    selectedPointer?.longitude.toString() ??
                                    widget.task?.lng ??
                                    "50.6854987",
                              );

                              if (widget.task == null) {
                                context.read<TaskDetailBloc>().add(
                                  CreateTaskEvent(task: task),
                                );
                              } else {
                                context.read<TaskDetailBloc>().add(
                                  EditTaskEvent(task: task),
                                );
                              }
                            }
                          },
                          isLoading: isLoading,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.task == null
                                    ? 'ایجاد و بستن'
                                    : 'تایید و بستن',
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Gap(8),
                              SvgPicture.asset(Assets.icons.tickSquare),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
