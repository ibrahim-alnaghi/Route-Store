import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../helpers/helper_functions.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = false,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
  });
  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: textColor ??
                  (HelperFunctions.isDarkMode(context)
                      ? AppColors.white
                      : AppColors.black)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: TextStyle(
                    color: textColor ??
                        (HelperFunctions.isDarkMode(context)
                            ? AppColors.white
                            : AppColors.black)),
              ))
      ],
    );
  }
}
