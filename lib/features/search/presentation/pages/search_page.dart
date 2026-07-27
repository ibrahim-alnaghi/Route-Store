import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/layouts/grid_view_layout.dart';
import '../../../../core/widgets/products/product_card_vertical.dart';
import '../../../../core/widgets/shimmer/product_card_vertical_shimmer.dart';
import '../blocs/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onQueryChanged);
  }

  void _onQueryChanged() {
    context.read<SearchBloc>().add(SearchQueryChanged(_searchController.text));
  }

  @override
  void dispose() {
    _searchController.removeListener(_onQueryChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search in Store',
            border: InputBorder.none,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.defaultSpace.h,
              horizontal: AppSizes.defaultSpace.w),
          child: BlocBuilder<SearchBloc, SearchStates>(
            builder: (context, state) {
              if (state.status == RequestStates.loading) {
                return const ProductCardVerticalShimmer(itemCount: 10);
              } else if (state.status == RequestStates.success &&
                  state.results != null &&
                  state.results!.isNotEmpty) {
                return GridViewLayout(
                  itemCount: state.results!.length,
                  itemBuilder: (context, index) => ProductCardVertical(
                      productEntity: state.results![index]),
                );
              } else if (state.status == RequestStates.success) {
                return AnimationLoader(
                    text: 'No products found for "${state.query}"',
                    animation: AppImages.emptyList);
              } else if (state.status == RequestStates.failure) {
                return Center(child: Text(state.errorMessage!));
              }
              return const AnimationLoader(
                  text: 'Search for products...',
                  animation: AppImages.emptyList);
            },
          ),
        ),
      ),
    );
  }
}
