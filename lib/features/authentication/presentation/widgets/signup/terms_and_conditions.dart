import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_strings.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../blocs/signup/signup_bloc.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupStates>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
                width: 24.w,
                height: 24.h,
                child: Checkbox(
                    value: state.agreedToTerms,
                    onChanged: (bool? value) {
                      context.read<SignupBloc>().add(ToggleAgreedToTerms());
                    })),
            SizedBox(width: AppSizes.spaceBtwItems.w),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: '${AppTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${AppTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: HelperFunctions.isDarkMode(context)
                        ? AppColors.white
                        : AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: HelperFunctions.isDarkMode(context)
                        ? AppColors.white
                        : AppColors.primary),
              ),
              TextSpan(
                text: '${AppTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${AppTexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: HelperFunctions.isDarkMode(context)
                        ? AppColors.white
                        : AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: HelperFunctions.isDarkMode(context)
                        ? AppColors.white
                        : AppColors.primary),
              ),
            ]))
          ],
        );
      },
    );
  }
}
