import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/products/cart/cart_item.dart';
import '../../../../core/widgets/products/product_price_text.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../checkout/domain/entities/order_entity.dart';
import '../widgets/order_status_display.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderEntity order;

  Widget _priceRow(BuildContext context, String label, num value,
      {bool isTotal = false}) {
    final textStyle = isTotal
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.sm / 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text('EGP $value', style: textStyle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.defaultSpace.h,
              horizontal: AppSizes.defaultSpace.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(title: 'Order', showActionButton: false),
              SizedBox(height: AppSizes.spaceBtwItems / 2.h),
              Text('[#${order.displayNumber}]',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: AppSizes.sm / 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('d MMM, yyyy')
                        .format(order.createdAt ?? DateTime.now()),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(order.status.label,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: order.status.color)),
                ],
              ),
              SizedBox(height: AppSizes.spaceBtwSections.h),
              if (order.shippingAddress != null) ...[
                const SectionHeading(
                    title: 'Shipping Address', showActionButton: false),
                SizedBox(height: AppSizes.spaceBtwItems / 2.h),
                Text(order.shippingAddress!.phone,
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(order.shippingAddress!.city,
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(order.shippingAddress!.details,
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: AppSizes.spaceBtwSections.h),
              ],
              const SectionHeading(
                  title: 'Payment Method', showActionButton: false),
              SizedBox(height: AppSizes.spaceBtwItems / 2.h),
              Text(order.paymentMethodType,
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: AppSizes.spaceBtwSections.h),
              if (order.orderItems.isNotEmpty) ...[
                const SectionHeading(
                    title: 'Items', showActionButton: false),
                SizedBox(height: AppSizes.spaceBtwItems.h),
                ...order.orderItems.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: AppSizes.spaceBtwItems.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CartItem(productDetails: item.productDetails),
                        SizedBox(height: AppSizes.sm.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Qty: ${item.itemCount}',
                                style: Theme.of(context).textTheme.bodySmall),
                            ProductPriceText(
                                price: item.itemPrice.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwSections.h),
              ],
              const SectionHeading(
                  title: 'Price Breakdown', showActionButton: false),
              _priceRow(
                  context,
                  'Items Subtotal',
                  order.orderItems
                      .fold<num>(0, (sum, item) => sum + item.itemPrice)),
              if (order.shippingPrice != null)
                _priceRow(context, 'Shipping', order.shippingPrice!),
              if (order.taxPrice != null)
                _priceRow(context, 'Tax', order.taxPrice!),
              const Divider(),
              _priceRow(context, 'Order Total', order.totalOrderPrice,
                  isTotal: true),
            ],
          ),
        ),
      ),
    );
  }
}
