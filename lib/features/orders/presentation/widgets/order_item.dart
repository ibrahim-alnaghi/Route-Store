import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/containers/rounded_container.dart';
import '../../../checkout/domain/entities/order_entity.dart';
import 'order_status_display.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.md.h, horizontal: AppSizes.md.w),
      backgroundColor: HelperFunctions.isDarkMode(context)
          ? AppColors.dark
          : AppColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Iconsax.ship),
              SizedBox(
                width: AppSizes.spaceBtwItems / 2.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Order Date',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      DateFormat('d MMM, yyyy')
                          .format(order.createdAt ?? DateTime.now()),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => context.pushNamed(
                      Routes.orderDetailsScreen,
                      arguments: order),
                  icon: const Icon(
                    Iconsax.arrow_right_34,
                    size: AppSizes.iconSm,
                  ))
            ],
          ),
          SizedBox(
            height: AppSizes.spaceBtwItems.h,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Iconsax.tag),
                    SizedBox(
                      width: AppSizes.spaceBtwItems / 2.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Order',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            '[#${order.displayNumber}]',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Iconsax.calendar),
                    SizedBox(
                      width: AppSizes.spaceBtwItems / 2.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Order State',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            order.status.label,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .apply(
                                    color: order.status.color,
                                    fontSizeDelta: 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
