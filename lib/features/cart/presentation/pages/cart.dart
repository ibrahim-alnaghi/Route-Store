import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_store/core/constants/colors.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/constants/image_strings.dart';
import 'package:route_store/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartStates>(
        builder: (context, state) {
          if (state.cart != null &&
              state.cart!.cartItems.cartProducts.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.defaultSpace.h,
                  horizontal: AppSizes.defaultSpace.w),
              child: ElevatedButton(
                onPressed: () => context.pushNamed(Routes.checkoutScreen),
                child: state.status == RequestStates.loading
                    ? const CircularProgressIndicator(
                        color: AppColors.white,
                      )
                    : Text('Checkout EGP ${state.cart!.cartItems.totalPrice}'),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.defaultSpace.h,
            horizontal: AppSizes.defaultSpace.w),
        child: BlocBuilder<CartBloc, CartStates>(
          builder: (context, state) {
            if (state.status == RequestStates.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
            } else if (state.cart != null &&
                state.cart!.cartItems.cartProducts.isNotEmpty) {
              return CartItems(cart: state.cart!.cartItems);
            } else {
              return AnimationLoader(
                text: 'Whoops! Cart is Empty.',
                animation: AppImages.emptyCart,
                showAction: true,
                actionText: 'Lit\'s fill it',
                onActionPressed: () => context.pushNamed(Routes.shop),
              );
            }
          },
        ),
      ),
    );
  }
}
