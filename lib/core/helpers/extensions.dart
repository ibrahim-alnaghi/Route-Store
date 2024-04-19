import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/sizes.dart';
import '../device/device_utility.dart';
import 'helper_functions.dart';

extension ContextExtensions on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void pop([result]) => Navigator.of(this).pop(result);

  void showCustomSnackBar({
    required SnackBarType type,
    required String message,
  }) {
    IconData icon;
    Color color;

    switch (type) {
      case SnackBarType.error:
        icon = Icons.error;
        color = AppColors.error;
        break;
      case SnackBarType.warning:
        icon = Icons.warning;
        color = AppColors.warning;
        break;
      case SnackBarType.success:
        icon = Icons.check_circle;
        color = AppColors.success;
        break;
      case SnackBarType.info:
        icon = Icons.info;
        color = AppColors.info;
        break;
      case SnackBarType.networkFailure:
        icon = Icons.wifi_off;
        color = Colors.amber;
        break;
      case SnackBarType.networkSuccess:
        icon = Icons.wifi;
        color = AppColors.info;
        break;
    }

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> showLoadingDialog(String text, String animation) async {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: HelperFunctions.isDarkMode(this)
              ? AppColors.dark
              : AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 250.h,
              ),
              AnimationLoader(
                text: text,
                animation: animation,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimationLoader extends StatelessWidget {
  const AnimationLoader(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed});

  final String text, animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: DeviceUtils.getScreenWidth(context) * 0.8),
          SizedBox(
            height: AppSizes.defaultSpace.h,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppSizes.defaultSpace.h,
          ),
          showAction
              ? SizedBox(
                  width: 250.w,
                  child: OutlinedButton(
                      onPressed: onActionPressed,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.dark),
                      child: Text(
                        actionText!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: AppColors.light),
                      )),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
