import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/components/app_outlined_button.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
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
              children: [
                Text(
                  'نام تسک :',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.gray5,
                  ),
                ),
                Gap(8),
                Text(
                  task.taskName ?? 'نامشخص',
                  style: context.textTheme.titleMedium,
                ),
                Gap(8),
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
            ),
            Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
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
                  onPressed: () {},
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
}
