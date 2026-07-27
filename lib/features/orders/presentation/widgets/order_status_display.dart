import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../checkout/domain/entities/order_entity.dart';

extension OrderStatusDisplay on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.pending:
        return 'Pending';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.delivered:
        return AppColors.primary;
      case OrderStatus.processing:
        return AppColors.info;
      case OrderStatus.pending:
        return AppColors.warning;
    }
  }
}
