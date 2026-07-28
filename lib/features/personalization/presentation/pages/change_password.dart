import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/validators/validation.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../bloc/change_password/change_password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Change Password'),
      ),
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordStates>(
        listener: (context, state) {
          if (state.status == RequestStates.loading) {
            context.showLoadingDialog(
                'Changing your password...', AppImages.docerAnimation);
          } else if (state.status == RequestStates.success) {
            context.pop();
            context.showCustomSnackBar(
                type: SnackBarType.success,
                message: 'Password changed, please log in again');
            context.pushNamedAndRemoveUntil(Routes.login);
          } else if (state.status == RequestStates.failure) {
            context.pop();
            context.showCustomSnackBar(
                type: SnackBarType.error, message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          final bloc = context.read<ChangePasswordBloc>();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.defaultSpace.h,
                  horizontal: AppSizes.defaultSpace.w),
              child: Form(
                key: bloc.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: bloc.currentPassword,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.next,
                      obscureText: !state.showCurrentPassword,
                      validator: (value) =>
                          Validator.validateNotEmpty(value, 'Current password'),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: GestureDetector(
                              onTap: () =>
                                  bloc.add(ToggleCurrentPasswordVisibility()),
                              child: Icon(state.showCurrentPassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye)),
                          labelText: 'Current Password'),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwInputFields.h,
                    ),
                    TextFormField(
                      controller: bloc.newPassword,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.next,
                      obscureText: !state.showNewPassword,
                      validator: (value) => Validator.validatePassword(value),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: GestureDetector(
                              onTap: () =>
                                  bloc.add(ToggleNewPasswordVisibility()),
                              child: Icon(state.showNewPassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye)),
                          labelText: 'New Password'),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwInputFields.h,
                    ),
                    TextFormField(
                      controller: bloc.confirmPassword,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.done,
                      obscureText: !state.showConfirmPassword,
                      validator: (value) {
                        if (value != bloc.newPassword.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: GestureDetector(
                              onTap: () =>
                                  bloc.add(ToggleConfirmPasswordVisibility()),
                              child: Icon(state.showConfirmPassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye)),
                          labelText: 'Confirm New Password'),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwSections.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (bloc.formKey.currentState!.validate()) {
                              bloc.add(SubmitChangePassword());
                            }
                          },
                          child: const Text('Change Password')),
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
