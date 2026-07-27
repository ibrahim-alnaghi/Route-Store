import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/containers/rounded_container.dart';
import '../../../../core/widgets/success_screen/success_screen.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../personalization/domain/entities/adress_entity.dart';
import '../../../personalization/presentation/bloc/adresses/adresses_bloc.dart';
import '../bloc/checkout_bloc.dart';
import '../widgets/billing_adress_section.dart';
import '../widgets/billing_amount_section.dart';
import '../widgets/billing_payment_section.dart';
import '../widgets/coupon_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  AdressEntity? _selectedAddress(AdressesStates state) {
    try {
      return state.adresses
          ?.firstWhere((a) => a.adressID == state.selectedAddress);
    } catch (e) {
      return null;
    }
  }

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
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state.status == RequestStates.success) {
              context.read<CartBloc>().add(GetCart());
              context.pushNamed(Routes.successScreen,
                  arguments: SuccessScreenModel(
                    animation: AppImages.paymentSuccessfulAnimation,
                    title: 'Payment Success',
                    subTitle: 'Your Item Well Be Shiped Soon',
                    onTap: (context) =>
                        context.pushNamedAndRemoveUntil(Routes.shop),
                  ));
            } else if (state.status == RequestStates.failure) {
              context.showCustomSnackBar(
                  type: SnackBarType.error,
                  message: state.errorMessage ?? 'Something went wrong');
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state.status == RequestStates.loading
                  ? null
                  : () {
                      final cartId =
                          context.read<CartBloc>().state.cart?.cartItems.cartId;
                      final selected =
                          _selectedAddress(context.read<AdressesBloc>().state);
                      if (cartId == null || cartId.isEmpty) {
                        context.showCustomSnackBar(
                            type: SnackBarType.warning,
                            message: 'Your cart is empty');
                        return;
                      }
                      if (selected == null) {
                        context.showCustomSnackBar(
                            type: SnackBarType.warning,
                            message: 'Please select a shipping address');
                        return;
                      }
                      context.read<CheckoutBloc>().add(PlaceOrder(
                          cartId: cartId, shippingAddress: selected));
                    },
              child: state.status == RequestStates.loading
                  ? const CircularProgressIndicator(color: AppColors.white)
                  : const Text('Checkout'),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.defaultSpace.h,
              horizontal: AppSizes.defaultSpace.w),
          child: Column(
            children: [
              RoundedContainer(
                showBorder: true,
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.md.h, horizontal: AppSizes.md.w),
                backgroundColor: HelperFunctions.isDarkMode(context)
                    ? AppColors.black
                    : AppColors.white,
                child: Column(
                  children: [
                    BlocBuilder<AdressesBloc, AdressesStates>(
                      builder: (context, state) => BillingAdressSection(
                        selectedAddress: _selectedAddress(state),
                        onChangePressed: () async {
                          await context.pushNamed(Routes.userAddressScreen);
                          if (context.mounted) {
                            context.read<AdressesBloc>().add(GetAdresses());
                          }
                        },
                      ),
                    ),
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
                    const Divider(),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    const CouponSection(),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    BlocBuilder<CartBloc, CartStates>(
                      builder: (context, state) => BillingAmountSection(
                          totalPrice: state.cart?.cartItems.totalPrice ?? 0),
                    ),
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
