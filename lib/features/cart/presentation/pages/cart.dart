import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:route_store/core/constants/colors.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/constants/image_strings.dart';
import 'package:route_store/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/icons/circular_icon.dart';
import '../widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _confirmClearCart(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text(
            'Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<CartBloc>().add(ClearCart());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          BlocBuilder<CartBloc, CartStates>(
            builder: (context, state) {
              if (state.cart != null &&
                  state.cart!.cartItems.cartProducts.isNotEmpty) {
                return CircularIcon(
                  icon: Iconsax.trash,
                  onPressed: () => _confirmClearCart(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
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
        child: BlocConsumer<CartBloc, CartStates>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == RequestStates.failure,
          listener: (context, state) => context.showCustomSnackBar(
              type: SnackBarType.error,
              message: state.errorMessage ?? 'Something went wrong'),
          builder: (context, state) {
            if (state.status == RequestStates.loading && state.cart == null) {
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
