import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/shimmer/address_shimmer.dart';
import '../bloc/adresses/adresses_bloc.dart';
import '../widgets/adress/single_address.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () =>
            context.pushNamed(Routes.addNewAddressScreen).then((value) {
          if (value != null && value == true) {
            context.read<AdressesBloc>().add(GetAdresses());
          }
        }),
        child: const Icon(
          Iconsax.add,
          color: AppColors.white,
        ),
      ),
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Addresses'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace.w,
              vertical: AppSizes.defaultSpace.h),
          child: BlocBuilder<AdressesBloc, AdressesStates>(
            builder: (context, state) {
              if (state.status == RequestStates.loading ||
                  state.adresses == null) {
                return ListView.builder(
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => const AddressShimmer(),
                );
              } else if (state.adresses != null && state.adresses!.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.adresses!.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => SingleAddress(
                    adress: state.adresses![index],
                    onTap: () => context.read<AdressesBloc>().add(
                        SelectedAddress(
                            selectedAddressID:
                                state.adresses![index].adressID)),
                  ),
                );
              }
              return const Center(
                child: Text('No Data Found'),
              );
            },
          ),
        ),
      ),
    );
  }
}
