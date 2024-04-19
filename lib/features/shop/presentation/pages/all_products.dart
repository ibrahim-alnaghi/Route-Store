import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/shimmer/product_card_vertical_shimmer.dart';
import '../../domain/entities/product_entity/product_entity.dart';
import '../blocs/all_products/all_products_bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/layouts/grid_view_layout.dart';
import '../../../../core/widgets/products/product_card_vertical.dart';

class AllProducts extends StatefulWidget {
  const AllProducts(
      {super.key, required this.title, required this.queryParameters});
  final String title;
  final Map<String, dynamic> queryParameters;

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late ScrollController _scrollController;
  int page = 1;
  bool isLoading = false;
  List<ProductEntity> allProducts = [];
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    var currentPosition = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPosition >= 0.7 * maxScrollLength) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    final Map<String, dynamic> nextPageParameters =
        Map.from(widget.queryParameters);
    nextPageParameters['page'] = page;

    if (!isLoading) {
      isLoading = true;

      context
          .read<AllProductsBloc>()
          .add(GetAllProducts(queryParameters: nextPageParameters));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.defaultSpace.h,
              horizontal: AppSizes.defaultSpace.w),
          child: BlocConsumer<AllProductsBloc, AllProductsStates>(
            listener: (context, state) {
              if (state.status == RequestStates.success) {
                allProducts.addAll(state.products!);
                if (state.products!.isNotEmpty) {
                  page++;
                  isLoading = false;
                }
              }
            },
            builder: (context, state) {
              if (state.status == RequestStates.loading &&
                  allProducts.isEmpty) {
                return const ProductCardVerticalShimmer(
                  itemCount: 10,
                );
              } else if (allProducts.isNotEmpty) {
                return Column(
                  children: [
                    GridViewLayout(
                      itemCount: allProducts.length,
                      itemBuilder: (context, index) => ProductCardVertical(
                          productEntity: allProducts[index]),
                    ),
                    if (state.status == RequestStates.loading &&
                        allProducts.isNotEmpty)
                      SizedBox(
                        height: AppSizes.gridViewSpacing.h,
                      ),
                    if (state.status == RequestStates.loading &&
                        allProducts.isNotEmpty)
                      const ProductCardVerticalShimmer(
                        itemCount: 10,
                      )
                  ],
                );
              } else if (state.status == RequestStates.failure) {
                return Center(
                  child: Text(state.errorMessage!),
                );
              }
              return AnimationLoader(
                  text: 'Whoops! No Products in ${widget.title}...',
                  animation: AppImages.emptyList);
            },
          ),
        ),
      ),
    );
  }
}
