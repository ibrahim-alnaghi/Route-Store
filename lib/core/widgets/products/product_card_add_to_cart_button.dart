import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:route_store/core/constants/colors.dart';
import 'package:route_store/core/constants/sizes.dart';
import 'package:route_store/core/di/injection_container.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_products_entity.dart';
import 'package:route_store/features/cart/presentation/bloc/cart_bloc.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.productID,
  });
  final String productID;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartBloc>(),
      child: BlocBuilder<CartBloc, CartStates>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => context.read<CartBloc>().add(AddToCart(productID)),
            child: Container(
              decoration: BoxDecoration(
                  color: getProductCount(state.cart) > 0
                      ? AppColors.primary
                      : AppColors.dark,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.cardRadiusMd.r),
                      bottomRight:
                          Radius.circular(AppSizes.productImageRadius.r))),
              child: SizedBox(
                width: AppSizes.iconLg * 1.2.w,
                height: AppSizes.iconLg * 1.2.h,
                child: Center(
                  child: getProductCount(state.cart) > 0
                      ? Text(
                          getProductCount(state.cart).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: AppColors.white),
                        )
                      : const Icon(
                          Iconsax.add,
                          color: AppColors.white,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  num getProductCount(CartEntity? cart) {
    final cartProducts = cart?.cartItems.cartProducts;
    CartProductsEntity? product;
    try {
      product = cartProducts?.firstWhere(
        (product) => product.productDetails.productId == productID,
      );
    } catch (e) {
      product = null;
    }

    return product?.itemCount ?? 0;
  }
}
