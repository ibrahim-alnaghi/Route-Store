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
import '../../blocs/login/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginStates>(
      listener: (context, state) {
        if (state.status == RequestStates.loading) {
          context.showLoadingDialog(
              'Logging you in...', AppImages.docerAnimation);
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
            key: context.read<LoginBloc>().formKey,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections.h),
              child: Column(
                children: [
                  TextFormField(
                    controller: context.read<LoginBloc>().email,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validator.validateEmail(value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: AppTexts.email),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwInputFields.h,
                  ),
                  TextFormField(
                    controller: context.read<LoginBloc>().password,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: !state.showPassword,
                    validator: (value) => Validator.validatePassword(value),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              context
                                  .read<LoginBloc>()
                                  .add(TogglePasswordVisibility());
                            },
                            child: Icon(state.showPassword
                                ? Iconsax.eye_slash
                                : Iconsax.eye)),
                        labelText: AppTexts.password),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwInputFields / 2.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          context.pushNamed(
                            Routes.forgetPassword,
                          );
                        },
                        child: const Text(AppTexts.forgetPassword)),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (context
                              .read<LoginBloc>()
                              .formKey
                              .currentState!
                              .validate()) {
                            context.read<LoginBloc>().add(Login());
                          }
                        },
                        child: const Text(AppTexts.signIn)),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwItems.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                          context.pushNamed(Routes.signup);
                        },
                        child: const Text(AppTexts.createAccount)),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
