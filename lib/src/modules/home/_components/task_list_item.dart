import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/components/app_outlined_button.dart';
import 'package:ofoq_kourosh_assessment/src/components/submit_button.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_bloc.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_event.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_routes/task_detail_route.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: EdgeInsets.symmetric(horizontal: 24),
      elevation: 5,
      shadowColor: AppColors.black.withValues(alpha: .1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نام تسک :',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.gray5,
                  ),
                ),
                Gap(8),
                Expanded(
                  child: Text(
                    task.taskName ?? 'نامشخص',
                    style: context.textTheme.titleMedium,
                  ),
                ),
                Gap(12),
                Spacer(),
                Text(
                  'تاریخ :',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.gray5,
                  ),
                ),
                Gap(8),
                Text(
                  task.createdAt ?? 'نامشخص',
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
            Gap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'توضیحات :',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.gray5,
                  ),
                ),
                Gap(8),
                Expanded(
                  child: Text(
                    task.taskDesc ?? 'نامشخص',
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            Gap(12),
            AppOutlinedButton(
              label: "نمایش موقعیت",
              iconPath: Assets.icons.location,
              enableColorButton: AppColors.blue,
              onTap: () {
                //TODO SHOULD GO TO Map PAGE
              },
            ),
            Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    var result = await TaskDetailRoutes.toTaskDetailPage(
                      context,
                      task: task,
                    );
                    if (result == true) {
                      context.read<HomeBloc>().add(FetchTaskListEvent());
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ویرایش',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                      const Gap(16),
                      SvgPicture.asset(Assets.icons.edit),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (task.id != null) {
                      showDeleteDialog(context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'حذف',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                      const Gap(16),
                      SvgPicture.asset(Assets.icons.delete),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('حذف', style: context.textTheme.bodyMedium),
                    ],
                  ),
                  Positioned(
                    top: .1,
                    left: .1,
                    child: InkWell(
                      onTap: context.pop,
                      child: Icon(Icons.close_rounded),
                    ),
                  ),
                ],
              ),
              Gap(32),
              Text(
                'آیا از انجام عملیات اطمینان دارید؟',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray10,
                ),
              ),
              Gap(32),
              Row(
                children: [
                  Expanded(
                    child: SubmitButton(
                      onTap: () {
                        context.read<HomeBloc>().add(DeleteTaskEvent(task.id!));
                        context.pop();
                      },
                      label: "تایید",
                    ),
                  ),
                  Gap(16),
                  Expanded(
                    child: AppOutlinedButton(onTap: context.pop, label: 'لغو'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
