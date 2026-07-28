import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/images/circular_image.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../widgets/profile/profile_menu.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.defaultSpace.h,
              horizontal: AppSizes.defaultSpace.w),
          child: Column(
            children: [
              Center(
                child: CircularImage(
                  image: AppImages.user,
                  width: 80.w,
                  height: 80.h,
                  padding: 0,
                ),
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems.h,
              ),
              const Divider(),
              SizedBox(
                height: AppSizes.spaceBtwItems.h,
              ),
              const SectionHeading(title: 'Profile Information'),
              SizedBox(
                height: AppSizes.spaceBtwItems.h,
              ),
              ProfileMenu(
                title: 'Name',
                value: getIt<UserEntity>().userName,
                onTap: () => context.pushNamed(Routes.editProfileScreen),
              ),
              ProfileMenu(
                title: 'Email',
                value: getIt<UserEntity>().userEmail,
                onTap: () => context.pushNamed(Routes.editProfileScreen),
              ),
              ProfileMenu(
                title: 'Password',
                value: '**********',
                onTap: () => context.pushNamed(Routes.changePasswordScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
