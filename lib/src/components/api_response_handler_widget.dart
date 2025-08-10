import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_request_status.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';

class ApiResponseHandlerWidget extends StatelessWidget {
  const ApiResponseHandlerWidget({
    super.key,
    required this.status,
    this.customNotStartedWidget,
    this.customLoadingWidget,
    this.customErrorWidget,
    required this.customSuccessWidget,
    required this.onRetryTapped,
  });

  final ApiRequestStatus status;
  final Widget? customNotStartedWidget;
  final Widget? customLoadingWidget;
  final Widget? customErrorWidget;
  final Widget customSuccessWidget;
  final VoidCallback onRetryTapped;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ApiRequestStatus.notStarted:
        return customNotStartedWidget ??
            customLoadingWidget ??
            const DefaultLoadingWidget();
      case ApiRequestStatus.loading:
        return customLoadingWidget ?? const DefaultLoadingWidget();
      case ApiRequestStatus.success:
        return customSuccessWidget;
      case ApiRequestStatus.unauthorized:
      case ApiRequestStatus.error:
        return customErrorWidget ??
            DefaultErrorWidget(onRetryTapped: onRetryTapped);
      case ApiRequestStatus.serverError:
        return kDebugMode ? const ServerErrorWidget() : const SizedBox();
    }
  }
}

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({super.key, required this.onRetryTapped});

  final VoidCallback onRetryTapped;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OutlinedButton(
          onPressed: onRetryTapped,
          child: Text("تلاش مجدد"),
        ),
      ),
    );
  }
}

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("خطای سمت سرور", style: context.textTheme.titleMedium),
    );
  }
}
