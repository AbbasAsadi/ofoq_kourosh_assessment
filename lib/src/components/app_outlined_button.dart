import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class AppOutlinedButton extends StatelessWidget {
  final double minWidth;
  final double height;
  final String label;
  final String? iconPath;
  final void Function()? onTap;
  final bool isLoading;
  final Color? enableColorButton;
  final Color? disableColorButton;

  const AppOutlinedButton({
    super.key,
    this.minWidth = 88,
    this.height = 41,
    required this.label,
    this.iconPath,
    this.onTap,
    this.isLoading = false,
    this.enableColorButton,
    this.disableColorButton,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        side: BorderSide(color: enableColorButton ?? AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        minimumSize: Size(minWidth, height),
      ),
      onPressed: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: isLoading
            ? const CircularProgressIndicator()
            : iconPath == null
            ? Text(
                label,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: enableColorButton ?? AppColors.primary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: enableColorButton ?? AppColors.primary,
                    ),
                  ),
                  const Gap(16),

                  SvgPicture.asset(iconPath!),
                ],
              ),
      ),
    );
  }
}
