import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../device/device_utility.dart';
import '../../helpers/helper_functions.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
  });
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: HelperFunctions.isDarkMode(context)
          ? AppColors.black
          : AppColors.white,
      child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: AppColors.primary,
          labelColor: HelperFunctions.isDarkMode(context)
              ? AppColors.white
              : AppColors.primary,
          unselectedLabelColor: AppColors.darkGrey,
          tabs: tabs),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
