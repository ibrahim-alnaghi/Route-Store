import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/widgets/brands/category_show_case.dart';
import '../../../../../core/widgets/shimmer/category_top_products_shimmer.dart';
import '../../../domain/entities/category_entity/category_entity.dart';
import '../../blocs/store/store_bloc.dart';

class CategoryTopProducts extends StatelessWidget {
  const CategoryTopProducts({
    super.key,
    required this.category,
  });

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreStates>(
      builder: (context, state) {
        if (state.status == RequestStates.loading ||
            state.topProducts == null) {
          return const CategoryTopProductsShimmer();
        }
        return CategoryShowCase(
          images:
              state.topProducts?.map((e) => e.productImageCover).toList() ?? [],
          category: category,
        );
      },
    );
  }
}
