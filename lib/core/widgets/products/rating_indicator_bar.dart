import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import '../../constants/colors.dart';

class RatingIndicatorBar extends StatelessWidget {
  const RatingIndicatorBar({
    super.key,
    required this.rating,
  });
  final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: AppColors.grey,
      itemBuilder: (BuildContext context, int index) => const Icon(
        Iconsax.star1,
        color: AppColors.primary,
      ),
    );
  }
}
