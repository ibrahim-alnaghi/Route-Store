import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/keys_constants.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_strings.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/validators/validation.dart';
import '../../blocs/signup/signup_bloc.dart';
import 'terms_and_conditions.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupStates>(
      listener: (context, state) {
        if (state.status == RequestStates.loading) {
          context.showLoadingDialog(
              'Account is being created...', AppImages.docerAnimation);
        } else if (state.status == RequestStates.success) {
          context.pop();
          CacheHelper.saveData(key: userkey, value: state.user!.toMap())
              .then((value) {
            if (value) {
              context.pushNamedAndRemoveUntil(
                Routes.shop,
              );
            }
          });
        } else if (state.status == RequestStates.failure) {
          context.pop();
          context.showCustomSnackBar(
              type: SnackBarType.error, message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Form(
            key: context.read<SignupBloc>().formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: context.read<SignupBloc>().firstName,
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${AppTexts.firstName} is required.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: AppTexts.firstName),
                      ),
                    ),
                    SizedBox(width: AppSizes.spaceBtwInputFields.w),
                    Expanded(
                      child: TextFormField(
                        controller: context.read<SignupBloc>().lastName,
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${AppTexts.lastName} is required.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: AppTexts.lastName),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields.h),
                TextFormField(
                  controller: context.read<SignupBloc>().email,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validator.validateEmail(value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct),
                      labelText: AppTexts.email),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields.h),
                TextFormField(
                  controller: context.read<SignupBloc>().phone,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (value) => Validator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.call),
                      labelText: AppTexts.phoneNo),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields.h),
                TextFormField(
                  controller: context.read<SignupBloc>().password,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  obscureText: !state.showPassword,
                  validator: (value) => Validator.validatePassword(value),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            context
                                .read<SignupBloc>()
                                .add(TogglePasswordVisibility());
                          },
                          child: Icon(state.showPassword
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                      labelText: AppTexts.password),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields.h),
                TextFormField(
                  controller: context.read<SignupBloc>().confirmPassword,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  obscureText: !state.showConfirmPassword,
                  validator: (value) => Validator.validatePassword(value),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            context
                                .read<SignupBloc>()
                                .add(ToggleConfirmPasswordVisibility());
                          },
                          child: Icon(state.showConfirmPassword
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                      labelText: AppTexts.confirmPassword),
                ),
                SizedBox(height: AppSizes.spaceBtwSections.h),
                const TermsAndConditions(),
                SizedBox(
                  height: AppSizes.spaceBtwItems.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: state.agreedToTerms
                          ? () {
                              if (context
                                  .read<SignupBloc>()
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                context.read<SignupBloc>().add(SignUp());
                              }
                            }
                          : null,
                      child: const Text(AppTexts.createAccount)),
                ),
              ],
            ));
      },
    );
  }
}
