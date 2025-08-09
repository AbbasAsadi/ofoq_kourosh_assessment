import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.focusNode,
    this.textInputAction,
    this.suffixText,
    this.prefixText,
    this.prefixIcon,
    this.maxLines,
    this.maxLength,
    // this.style,
    this.textDirection,
    this.onChanged,
    this.enable,
    this.validator,
    this.inputFormatters,
    this.onTapOutside,
    this.obscureText,
    this.onFieldSubmitted,
  });

  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final String? prefixText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final bool? enable;
  final bool? obscureText;
  final TextDirection? textDirection;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<PointerDownEvent>? onTapOutside;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool? isObscure = widget.obscureText;

  void toggleObscureText() => setState(() => isObscure = !(isObscure ?? true));

  @override
  Widget build(BuildContext context) {
    TextStyle? style = context.textTheme.labelMedium?.copyWith(
      color: AppColors.black,
    );

    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      focusNode: widget.focusNode,
      validator: widget.validator,
      obscureText: isObscure ?? false,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      enabled: widget.enable,
      onTapOutside:
          widget.onTapOutside ??
          (PointerDownEvent pointerDownEvent) {
            FocusScope.of(context).unfocus();
          },
      textDirection: widget.textDirection,
      style: style,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: style?.copyWith(color: AppColors.textGray),
        counter: const SizedBox(),
        border: InputBorder.none,
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: widget.labelText,
        errorStyle: context.textTheme.labelSmall?.copyWith(
          color: AppColors.red,
        ),
        suffixIcon: (isObscure != null
            ? IconButton(
                icon: Icon(
                  isObscure! ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: toggleObscureText,
              )
            : null),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: widget.prefixIcon,
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 24, maxWidth: 40),
        // prefixIcon: prefixText,
      ),
    );
  }
}
