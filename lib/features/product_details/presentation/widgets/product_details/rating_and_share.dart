import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../shop/domain/entities/product_entity/product_entity.dart';

class RatingAndShare extends StatelessWidget {
  final ProductEntity productEntity;
  const RatingAndShare({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            SizedBox(
              width: AppSizes.spaceBtwItems.w,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: productEntity.averageRatings.toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(text: '(${productEntity.quantityRatings.toString()})')
            ]))
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: AppSizes.iconMd,
            ))
      ],
    );
  }
}
