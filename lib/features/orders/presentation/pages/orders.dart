import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../bloc/orders_bloc.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace.w,
            vertical: AppSizes.defaultSpace.h),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state.status == RequestStates.loading &&
                state.orders == null) {
              return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state.status == RequestStates.failure) {
              return Center(child: Text(state.errorMessage ?? ''));
            } else if (state.orders != null && state.orders!.isNotEmpty) {
              return ListView.separated(
                itemCount: state.orders!.length,
                separatorBuilder: (_, __) => SizedBox(
                  height: AppSizes.spaceBtwItems.h,
                ),
                itemBuilder: (_, index) =>
                    OrderItem(order: state.orders![index]),
              );
            }
            return const AnimationLoader(
                text: 'Whoops! No Orders Yet.', animation: AppImages.emptyList);
          },
        ),
      ),
    );
  }
}
