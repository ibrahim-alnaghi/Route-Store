import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/texts/section_heading.dart';
import '../../../domain/entities/category_entity/category_entity.dart';
import '../../blocs/store/store_bloc.dart';
import 'category_products.dart';
import 'category_top_products.dart';

class CategoryTab extends StatefulWidget {
  final CategoryEntity category;
  const CategoryTab({super.key, required this.category});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  void initState() {
    context.read<StoreBloc>().add(GeStoretProducts(queryParameters: {
          'category[in]': widget.category.categoryID,
          'limit': 7
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace.h,
            vertical: AppSizes.defaultSpace.w),
        child: Column(
          children: [
            CategoryTopProducts(category: widget.category),
            SectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () =>
                    context.pushNamed(Routes.allProducts, arguments: {
                      'queryParameters': {
                        'category[in]': widget.category.categoryID,
                      },
                      'title': widget.category.categoryName,
                    })),
            SizedBox(
              height: AppSizes.spaceBtwItems.h,
            ),
            CategoryProducts(
              category: widget.category,
            ),
            SizedBox(
              height: AppSizes.spaceBtwSections.h,
            ),
          ],
        ),
      ),
    ]);
  }
}
