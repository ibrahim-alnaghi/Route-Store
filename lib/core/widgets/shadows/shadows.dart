import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ShadowsStyle {
  static final verticalProduct = BoxShadow(
      color: AppColors.darkContainer.withOpacity(.01),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProduct = BoxShadow(
      color: AppColors.darkContainer.withOpacity(.01),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
