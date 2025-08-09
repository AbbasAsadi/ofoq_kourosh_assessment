import 'package:flutter/material.dart';
import 'package:ofoq_kourosh_assessment/src/components/snack_bar/custom_snack_bar.dart';
import 'package:ofoq_kourosh_assessment/src/components/snack_bar/top_snack_bar.dart';

mixin ErrorHandler {
  static bool isSnackBarOpen = false;

  void showError({required BuildContext context, required String message}) {
    showTopSnackBar(context, CustomSnackBar.error(message: message));
  }

  void showWarning(BuildContext context, String message) {
    showTopSnackBar(context, CustomSnackBar.info(message: message));
  }

  void showSuccessMessage(
    BuildContext context,
    String message, {
    EdgeInsetsGeometry messagePadding = const EdgeInsets.symmetric(
      horizontal: 8,
    ),
  }) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(message: message, messagePadding: messagePadding),
    );
  }
}
