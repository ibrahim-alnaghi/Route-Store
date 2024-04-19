import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/products/rating_indicator_bar.dart';
import '../widgets/product_reviews/overall_product_rating.dart';
import '../widgets/product_reviews/user_review_card.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace.w,
              vertical: AppSizes.defaultSpace.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OverallProductRating(),
              const RatingIndicatorBar(
                rating: 4.8,
              ),
              Text(
                '12,000',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: AppSizes.spaceBtwSections.h,
              ),
              const UserReviewCard(
                name: 'Mohamed Sultan',
                image: AppImages.userProfileImage1,
                comment:
                    "تجربة رائعة! المنتج جاء بجودة عالية وتوصيل سريع جداً. شكراً لكم على الخدمة الممتازة!",
              ),
              const UserReviewCard(
                name: 'Mostafa Hashem',
                image: AppImages.userProfileImage2,
                comment:
                    "لا يمكنني سوى إعطاء خمس نجوم! كل شيء كان مثالياً من البداية إلى النهاية. أنا سعيد جداً بمشترياتي!",
              ),
              const UserReviewCard(
                  name: 'Mohamed Hamouda',
                  image: AppImages.userProfileImage3,
                  comment:
                      "أفضل تجربة للتسوق عبر الإنترنت على الإطلاق! المنتج وصل في حالة ممتازة وفي وقت سريع جداً. شكراً لكم على الخدمة الرائعة!"),
            ],
          ),
        ),
      ),
    );
  }
}
