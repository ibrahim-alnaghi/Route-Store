import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/text_strings.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/validators/validation.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../blocs/forgot_password/forgot_password_bloc.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordStates>(
        listener: (context, state) {
          if (state.status == RequestStates.loading) {
            context.showLoadingDialog(
                'Processing your request...', AppImages.docerAnimation);
          } else if (state.status == RequestStates.success) {
            context.pop();
            context.showCustomSnackBar(
                type: SnackBarType.success, message: state.successMessage!);
            context.pushReplacementNamed(
              Routes.otpScreen,
            );
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
                key: context.read<ForgotPasswordBloc>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.forgetPasswordTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    Text(
                      AppTexts.forgetPasswordSubTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwItems * 2.h,
                    ),
                    TextFormField(
                      controller: context.read<ForgotPasswordBloc>().email,
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
                      height: AppSizes.spaceBtwSections.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (context
                                .read<ForgotPasswordBloc>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context
                                  .read<ForgotPasswordBloc>()
                                  .add(SendCode());
                            }
                          },
                          child: const Text(AppTexts.cContinue)),
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
