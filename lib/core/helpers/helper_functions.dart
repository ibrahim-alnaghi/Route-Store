import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/authentication/domain/entities/user_entity.dart';
import '../constants/keys_constants.dart';
import '../di/injection_container.dart';
import '../local_storage/cache_helper.dart';
import '../routes/routes.dart';

class HelperFunctions {
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static String getRoute() {
    var userToken = getIt<UserEntity>().userToken;
    var onBoarding = CacheHelper.getData(onBoardingKey);
    String route;
    if (onBoarding != null) {
      if (userToken.isNotEmpty) {
        route = Routes.shop;
      } else {
        route = Routes.login;
      }
    } else {
      route = Routes.onboarding;
    }
    return route;
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
