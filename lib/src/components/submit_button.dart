import 'package:flutter/material.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    this.onTap,
    this.label,
    this.child,
    this.isLoading = false,
    this.padding,
    this.radius,
    this.backgroundColor,
    this.textColor = AppColors.white,
    this.maxLines,
    this.textAlign,
    this.paddingInside,
    this.textStyle,
    this.disabledBackgroundColor,
    this.autoFocus = false,
    this.focusNode,
    this.focusColor,
    this.loadingSize = 34,
  });

  final VoidCallback? onTap;
  final String? label;
  final Widget? child;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? focusColor;
  final Color? disabledBackgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingInside;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? radius;
  final TextStyle? textStyle;
  final bool autoFocus;
  final FocusNode? focusNode;
  final double? loadingSize;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      focusNode: focusNode,
      autofocus: autoFocus,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(paddingInside),
        backgroundColor: WidgetStateColor.fromMap({
          if (disabledBackgroundColor != null)
            WidgetState.disabled: disabledBackgroundColor!
          else
            WidgetState.disabled: Colors.grey,
          WidgetState.focused:
              focusColor ?? context.theme.colorScheme.inversePrimary,
          WidgetState.any: backgroundColor ?? AppColors.primary,
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 12),
              side: const BorderSide(color: Colors.white, width: 2),
            );
          }
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12),
          );
        }),
      ),

      onPressed: isLoading ? null : onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.all(isLoading ? 8 : 12),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: loadingSize,
                  width: loadingSize,
                  child: const CircularProgressIndicator(),
                )
              : child ??
                    Text(
                      label ?? '',
                      textAlign: textAlign,
                      maxLines: maxLines,
                      style: (textStyle ?? context.textTheme.titleLarge)
                          ?.copyWith(
                            color: onTap == null ? AppColors.white : textColor,
                          ),
                    ),
        ),
      ),
    );
  }
}
