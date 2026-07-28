import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/text_strings.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/validators/validation.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../bloc/edit_profile/edit_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Edit Profile'),
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileStates>(
        listener: (context, state) {
          if (state.status == RequestStates.loading) {
            context.showLoadingDialog(
                'Updating your profile...', AppImages.docerAnimation);
          } else if (state.status == RequestStates.success) {
            context.pop();
            context.pop();
            context.showCustomSnackBar(
                type: SnackBarType.success,
                message: 'Profile updated successfully');
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
                  vertical: AppSizes.defaultSpace.h,
                  horizontal: AppSizes.defaultSpace.w),
              child: Form(
                key: context.read<EditProfileBloc>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: context.read<EditProfileBloc>().name,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (value) =>
                          Validator.validateNotEmpty(value, 'Name'),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: AppTexts.username),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwInputFields.h,
                    ),
                    TextFormField(
                      controller: context.read<EditProfileBloc>().email,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validator.validateEmail(value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: AppTexts.email),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwSections.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (context
                                .read<EditProfileBloc>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context
                                  .read<EditProfileBloc>()
                                  .add(SubmitUpdateProfile());
                            }
                          },
                          child: const Text('Save Changes')),
                    ),
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
