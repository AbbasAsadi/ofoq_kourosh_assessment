import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/components/app_text_field.dart';
import 'package:ofoq_kourosh_assessment/src/components/submit_button.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/helper/app_validator.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_bloc.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_state.dart';

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

class _TaskDetailPageState extends State<_TaskDetailPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController taskTitleTextController = TextEditingController();
  final TextEditingController taskDescriptionTextController =
      TextEditingController();

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
    return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('عنوان:', style: context.textTheme.labelMedium),
                  Gap(8),
                  AppTextField(
                    controller: taskTitleTextController,
                    hintText: "عنوان",
                    validator: AppValidator.globalValidator,
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
                Container(color: Colors.green),
                Positioned(
                  right: 24,
                  left: 24,
                  bottom: 24,
                  child: SubmitButton(
                    onTap: () {
                      //TODO SHOULD CREATE OR EDIT TASK
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.task == null ? 'ایجاد و بستن' : 'تایید و بستن',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Gap(8),
                        SvgPicture.asset(Assets.icons.tickSquare),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
