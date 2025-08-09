import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

/// Popup widget that you can use by default to show some information
class CustomSnackBar extends StatefulWidget {
  CustomSnackBar.success({
    super.key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 8),
    SvgPicture? icon,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.gray10,
    ),
    this.maxLines = 4,
    this.backgroundColor = AppColors.lightGreen,
    this.borderRadius = kDefaultBorderRadius,
    this.textButton,
  }) : icon = icon ?? SvgPicture.asset(Assets.icons.greenTick);

  CustomSnackBar.info({
    super.key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 8),
    SvgPicture? icon,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.gray10,
    ),
    this.maxLines = 4,
    this.backgroundColor = AppColors.lightOrange,
    this.borderRadius = kDefaultBorderRadius,
    this.textButton,
  }) : icon = icon ?? SvgPicture.asset(Assets.icons.infoIcon);

  CustomSnackBar.error({
    super.key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 8),
    SvgPicture? icon,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.gray10,
    ),
    this.maxLines = 4,
    this.backgroundColor = AppColors.lightRed,
    this.borderRadius = kDefaultBorderRadius,
    this.textButton,
  }) : icon = icon ?? SvgPicture.asset(Assets.icons.errorInfo);

  final String message;
  final Widget icon;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int maxLines;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry messagePadding;
  final Widget? textButton;

  @override
  CustomSnackBarState createState() => CustomSnackBarState();
}

class CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(height: 24, child: widget.icon),
                  ),
                  Expanded(
                    child: Padding(
                      padding: widget.messagePadding,
                      child: Text(
                        widget.message,
                        style: context.textTheme.bodyMedium?.merge(
                          widget.textStyle,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: widget.maxLines,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.textButton != null) widget.textButton!,
          ],
        ),
      ),
    );
  }
}

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(8));
