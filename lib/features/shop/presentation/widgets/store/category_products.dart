import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/widgets/layouts/grid_view_layout.dart';
import '../../../../../core/widgets/products/product_card_vertical.dart';
import '../../../../../core/widgets/shimmer/product_card_vertical_shimmer.dart';
import '../../../domain/entities/category_entity/category_entity.dart';
import '../../blocs/store/store_bloc.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({
    super.key,
    required this.category,
  });
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreStates>(
      builder: (context, state) {
        if (state.status == RequestStates.loading || state.products == null) {
          return const ProductCardVerticalShimmer();
        } else if (state.products != null && state.products!.isNotEmpty) {
          return GridViewLayout(
            itemCount: state.products!.length,
            itemBuilder: (context, index) =>
                ProductCardVertical(productEntity: state.products![index]),
          );
        }
        return const AnimationLoader(
            text: 'Whoops! No Products in This Category...',
            animation: AppImages.emptyList);
      },
    );
  }
}
