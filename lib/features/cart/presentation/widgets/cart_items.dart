import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_items.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/products/cart/cart_item.dart';
import '../../../../core/widgets/products/cart/product_quantity_with_add_and_remove_buttons.dart';
import '../../../../core/widgets/products/product_price_text.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    this.showAddAndRemoveButtons = true,
    required this.cart,
  });
  final bool showAddAndRemoveButtons;
  final CartItemsEntity cart;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: AppSizes.spaceBtwSections.h,
      ),
      itemBuilder: (context, index) => Column(
        children: [
          CartItem(
            productDetails: cart.cartProducts[index].productDetails,
          ),
          if (showAddAndRemoveButtons)
            SizedBox(
              height: AppSizes.spaceBtwItems.h,
            ),
          if (showAddAndRemoveButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80.w,
                    ),
                    ProductQuantityWithAddAndRemoveButtons(
                      cartProductsEntity: cart.cartProducts[index],
                    ),
                  ],
                ),
                ProductPriceText(
                    price: cart.cartProducts[index].itemPrice.toString())
              ],
            )
        ],
      ),
      itemCount: cart.cartProducts.length,
      shrinkWrap: true,
    );
  }
}
