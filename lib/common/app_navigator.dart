import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/common/app_text_style.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator({required this.context});

  void pop({Object? extra}) {
    GoRouter.of(context).pop(extra);
  }

  Future<dynamic> pushName(String name, {Object? arguments}) {
    return GoRouter.of(context).pushNamed(name, extra: arguments);
  }

  Future<dynamic> pushReplacementName(String name, {Object? arguments}) {
    return GoRouter.of(context).pushReplacementNamed(name, extra: arguments);
  }

  void showLoadingOverlay() {
    context.loaderOverlay.show();
  }

  void hideLoadingOverlay() {
    context.loaderOverlay.hide();
  }

  Future<void> showSimpleDialog({
    required String title,
    required String content,
    String textConfirm = "OK",
    String? textCancel,
    barrierDismissible = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: AppTextStyles.bMediumSemiBold),
          content: Text(content, style: AppTextStyles.bMediumMedium),
          actions: [
            if (textCancel != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Text(textCancel, style: AppTextStyles.bMediumSemiBold),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(textConfirm, style: AppTextStyles.bMediumSemiBold),
            ),
          ],
        );
      },
    );
  }
}
