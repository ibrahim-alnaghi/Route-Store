import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/containers/rounded_container.dart';
import '../../../../core/widgets/success_screen/success_screen.dart';
import '../widgets/billing_adress_section.dart';
import '../widgets/billing_amount_section.dart';
import '../widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.defaultSpace.h,
            horizontal: AppSizes.defaultSpace.w),
        child: ElevatedButton(
            onPressed: () => context.pushNamed(Routes.successScreen,
                arguments: SuccessScreenModel(
                  animation: AppImages.paymentSuccessfulAnimation,
                  title: 'Payment Success',
                  subTitle: 'Your Item Well Be Shiped Soon',
                  onTap: (context) =>
                      context.pushNamedAndRemoveUntil(Routes.shop),
                )),
            child: const Text('Checkout \$300')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.defaultSpace.h,
              horizontal: AppSizes.defaultSpace.w),
          child: Column(
            children: [
              // const CartItems(
              //   showAddAndRemoveButtons: false,
              // ),
              SizedBox(
                height: AppSizes.spaceBtwSections.h,
              ),
              RoundedContainer(
                showBorder: true,
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.md.h, horizontal: AppSizes.md.w),
                backgroundColor: HelperFunctions.isDarkMode(context)
                    ? AppColors.black
                    : AppColors.white,
                child: Column(
                  children: [
                    const BillingAmountSection(),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    const BillingPaymentSection(),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    const BillingAdressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
