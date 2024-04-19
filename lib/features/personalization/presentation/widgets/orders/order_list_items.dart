import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/sizes.dart';
import 'order_item.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      separatorBuilder: (_, __) => SizedBox(
        height: AppSizes.spaceBtwItems.h,
      ),
      itemBuilder: (_, __) => const OrderItem(),
    );
  }
}
