import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/keys_constants.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/containers/primary_header_container.dart';
import '../../../../core/widgets/list_tiles/settings_mneu_tile.dart';
import '../../../../core/widgets/list_tiles/user_profile_tile.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../bloc/personalization/personalization_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  CustomAppBar(
                      title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: AppColors.white),
                  )),
                  const UserProfileTile(),
                  SizedBox(
                    height: AppSizes.spaceBtwSections.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.defaultSpace.h,
                  horizontal: AppSizes.defaultSpace.w),
              child: Column(
                children: [
                  const SectionHeading(
                    title: 'Account Settings',
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwItems.h,
                  ),
                  SettingsMneuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shoping delivery address',
                    onTap: () => context.pushNamed(Routes.userAddressScreen),
                  ),
                  SettingsMneuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add,remove products and move to checkout',
                    onTap: () => context.pushNamed(Routes.cartScreen),
                  ),
                  SettingsMneuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-Progress and Complated Orders',
                    onTap: () => context.pushNamed(Routes.orderScreen),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections.h,
                  ),
                  const SectionHeading(
                    title: 'App Settings',
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwItems.h,
                  ),
                  BlocBuilder<PersonalizationBloc, PersonalizationStates>(
                    builder: (context, state) {
                      return SettingsMneuTile(
                        icon: Iconsax.moon,
                        title: 'Dark Mood',
                        subTitle: 'Set Theme to Dark Mood',
                        trailing: Switch(
                          thumbColor:
                              const MaterialStatePropertyAll(AppColors.white),
                          inactiveTrackColor:
                              AppColors.primary.withOpacity(0.5),
                          activeTrackColor: AppColors.primary,
                          value: state.isDark,
                          onChanged: (value) {
                            context
                                .read<PersonalizationBloc>()
                                .add(ChangeThemeMode());
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                          CacheHelper.removeData(userkey).then((value) {
                            if (value) {
                              context.pushNamedAndRemoveUntil(Routes.login);
                            }
                          });
                        },
                        child: const Text('Logout')),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections * 2.5.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
