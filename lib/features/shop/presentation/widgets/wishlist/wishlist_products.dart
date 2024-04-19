import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/widgets/layouts/grid_view_layout.dart';
import '../../../../../core/widgets/products/product_card_vertical.dart';
import '../../blocs/shop/shop_bloc.dart';
import '../../blocs/wishlist/wishlist_bloc.dart';

class WishlistProducts extends StatelessWidget {
  const WishlistProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<WishlistBloc>(),
      child: BlocConsumer<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if (state is GetFavErrorState) {
            context.showCustomSnackBar(
                type: SnackBarType.error, message: state.message);
          }
        },
        builder: (context, state) {
          if (state.products.isNotEmpty) {
            return GridViewLayout(
              itemCount: state.products.length,
              itemBuilder: (context, index) =>
                  ProductCardVertical(productEntity: state.products[index]),
            );
          } else {
            return AnimationLoader(
                text: 'Whoops! WishList is Empty...',
                showAction: true,
                actionText: 'Let\'s add some',
                onActionPressed: () => context
                    .read<ShopBloc>()
                    .add(const SelectNavigationEvent(0)),
                animation: AppImages.emptyList);
          }
        },
      ),
    );
  }
}
