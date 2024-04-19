import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/validators/validation.dart';
import '../bloc/adresses/adresses_bloc.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Add New Address'),
      ),
      body: BlocConsumer<AdressesBloc, AdressesStates>(
        listener: (context, state) {
          if (state.status == RequestStates.loading) {
            context.showLoadingDialog(
                'Storing Address...', AppImages.docerAnimation);
          } else if (state.status == RequestStates.success) {
            context.pop();
            context.pop(true);
          } else if (state.status == RequestStates.failure) {
            context.pop();
            context.showCustomSnackBar(
                type: SnackBarType.error, message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace.w,
                  vertical: AppSizes.defaultSpace.h),
              child: Form(
                key: context.read<AdressesBloc>().formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      controller: context.read<AdressesBloc>().name,
                      validator: (value) =>
                          Validator.validateNotEmpty(value, 'Name'),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwInputFields.h,
                    ),
                    TextFormField(
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: context.read<AdressesBloc>().phone,
                      validator: (value) =>
                          Validator.validatePhoneNumber(value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile),
                          labelText: 'Phone Number'),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwInputFields.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.streetAddress,
                            controller: context.read<AdressesBloc>().street,
                            validator: (value) =>
                                Validator.validateNotEmpty(value, 'Street'),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building_31),
                                labelText: 'Street'),
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.spaceBtwInputFields.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            controller: context.read<AdressesBloc>().area,
                            validator: (value) =>
                                Validator.validateNotEmpty(value, 'Area'),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.location),
                                labelText: 'Area'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwInputFields.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            controller: context.read<AdressesBloc>().postalCode,
                            validator: (value) => Validator.validateNotEmpty(
                                value, 'Postal Code'),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: 'Postal Code'),
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.spaceBtwInputFields.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            controller: context.read<AdressesBloc>().city,
                            validator: (value) =>
                                Validator.validateNotEmpty(value, 'City'),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.buliding),
                                labelText: 'City'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.defaultSpace.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (context
                                .read<AdressesBloc>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<AdressesBloc>().add(AddAdress());
                            }
                          },
                          child: const Text('Save')),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
