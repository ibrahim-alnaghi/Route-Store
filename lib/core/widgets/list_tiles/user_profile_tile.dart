import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/authentication/domain/entities/user_entity.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../di/injection_container.dart';
import '../../helpers/extensions.dart';
import '../../routes/routes.dart';
import '../images/circular_image.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(
        image: AppImages.user,
        width: 45.w,
        height: 45.h,
        padding: 0,
      ),
      title: Text(
        getIt<UserEntity>().userName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: AppColors.white),
      ),
      subtitle: Text(
        getIt<UserEntity>().userEmail,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: AppColors.white),
      ),
      trailing: IconButton(
          onPressed: () {
            context.pushNamed(Routes.userProfileScreen);
          },
          icon: const Icon(
            Iconsax.edit,
            color: AppColors.white,
          )),
    );
  }
}
