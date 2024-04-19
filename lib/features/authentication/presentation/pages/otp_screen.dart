import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/text_strings.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../blocs/forgot_password/forgot_password_bloc.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String otpCode = '';

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordStates>(
        listener: (context, state) {
          if (state.status == RequestStates.loading) {
            context.showLoadingDialog(
                'Checking otp code...', AppImages.docerAnimation);
          } else if (state.status == RequestStates.success) {
            context.pop();
            context.showCustomSnackBar(
                type: SnackBarType.success, message: state.successMessage!);
            context.pushReplacementNamed(Routes.restPassword);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.changeYourPasswordTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    Text(
                      AppTexts.changeYourPasswordSubTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwItems * 2.h,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      autoFocus: true,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5.r),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        borderWidth: 1,
                        activeColor: AppColors.borderPrimary,
                        inactiveColor: AppColors.borderPrimary,
                        selectedColor: AppColors.borderPrimary,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      onCompleted: (submitedCode) {
                        otpCode = submitedCode;
                        context
                            .read<ForgotPasswordBloc>()
                            .add(VerifyCode(otpCode));
                      },
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwSections.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (otpCode.isNotEmpty) {
                              context
                                  .read<ForgotPasswordBloc>()
                                  .add(VerifyCode(otpCode));
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
