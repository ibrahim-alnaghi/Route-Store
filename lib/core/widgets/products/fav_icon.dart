import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/presentation/blocs/wishlist/wishlist_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../di/injection_container.dart';
import '../../helpers/extensions.dart';
import '../icons/circular_icon.dart';

class FavIcon extends StatelessWidget {
  const FavIcon({
    super.key,
    required this.productID,
  });
  final String productID;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<WishlistBloc>(),
      child: BlocConsumer<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if (state is AddToFavErrorState) {
            context.showCustomSnackBar(
                type: SnackBarType.error, message: state.message);
          }

          if (state is RemoveFavErrorState) {
            context.showCustomSnackBar(
                type: SnackBarType.error, message: state.message);
          }
        },
        builder: (context, state) {
          return CircularIcon(
            icon: state.favorites[productID] ?? false
                ? Iconsax.heart5
                : Iconsax.heart,
            color: state.favorites[productID] ?? false ? AppColors.error : null,
            onPressed: () => context
                .read<WishlistBloc>()
                .add(ChangeFav(productID: productID)),
          );
        },
      ),
    );
  }
}
