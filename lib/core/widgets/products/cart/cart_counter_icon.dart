import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:route_store/core/di/injection_container.dart';
import 'package:route_store/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../constants/colors.dart';
import '../../../helpers/helper_functions.dart';

class CartCounterIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? iconColor;
  const CartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartBloc>(),
      child: BlocBuilder<CartBloc, CartStates>(
        builder: (context, state) {
          return Stack(
            children: [
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Iconsax.shopping_bag,
                    color: iconColor ??
                        (HelperFunctions.isDarkMode(context)
                            ? AppColors.white
                            : AppColors.black),
                  )),
              if (state.cart != null && state.cart!.cartItemsCount != 0)
                Positioned(
                  right: 0,
                  child: Container(
                    width: 18.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100.r)),
                    child: Center(
                        child: Text(
                      state.cart!.cartItemsCount.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: AppColors.white, fontSizeFactor: 0.8),
                    )),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
