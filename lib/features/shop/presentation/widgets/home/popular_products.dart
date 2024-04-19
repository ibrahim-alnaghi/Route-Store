import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/layouts/grid_view_layout.dart';
import '../../../../../core/widgets/products/product_card_vertical.dart';
import '../../../../../core/widgets/shimmer/product_card_vertical_shimmer.dart';
import '../../blocs/home/home_bloc.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        if (state.products == null) {
          return const ProductCardVerticalShimmer();
        } else if (state.products != null && state.products!.isNotEmpty) {
          return GridViewLayout(
            itemCount: state.products!.length,
            itemBuilder: (context, index) =>
                ProductCardVertical(productEntity: state.products![index]),
          );
        }
        return const Center(
          child: Text('No Data Found'),
        );
      },
    );
  }
}
