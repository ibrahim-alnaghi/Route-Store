import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/widgets/containers/rounded_container.dart';
import '../../../domain/entities/adress_entity.dart';
import '../../bloc/adresses/adresses_bloc.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.adress,
    required this.onTap,
  });

  final AdressEntity adress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdressesBloc, AdressesStates>(
      builder: (context, state) {
        final String selectedAddressID = state.selectedAddress;
        final bool selectedAddress = selectedAddressID == adress.adressID;
        return GestureDetector(
          onTap: onTap,
          child: RoundedContainer(
            width: double.infinity,
            showBorder: true,
            backgroundColor: selectedAddress
                ? AppColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : HelperFunctions.isDarkMode(context)
                    ? AppColors.darkerGrey
                    : AppColors.grey,
            margin: EdgeInsets.only(bottom: AppSizes.spaceBtwItems.h),
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.md.w, vertical: AppSizes.md.h),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 5.w,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? HelperFunctions.isDarkMode(context)
                            ? AppColors.light
                            : AppColors.dark
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adress.adressName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: AppSizes.sm / 2.h,
                    ),
                    Text(adress.adressPhone),
                    SizedBox(
                      height: AppSizes.sm / 2.h,
                    ),
                    Text(
                      adress.adressDetails,
                      softWrap: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
