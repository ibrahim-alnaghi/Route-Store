import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class CouponSection extends StatefulWidget {
  const CouponSection({super.key});

  @override
  State<CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends State<CouponSection> {
  late TextEditingController _couponController;

  @override
  void initState() {
    super.initState();
    _couponController = TextEditingController();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyCoupon() {
    final code = _couponController.text.trim();
    if (code.isEmpty) return;
    context.read<CartBloc>().add(ApplyCoupon(code));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartStates>(
      // Keyed on couponVersion (bumped once per apply attempt), not on the
      // message/error text itself — two attempts in a row can produce the
      // exact same text (e.g. retrying the same invalid coupon), and
      // comparing text would silently suppress the second notification.
      listenWhen: (previous, current) =>
          previous.couponVersion != current.couponVersion,
      listener: (context, state) {
        if (state.status == RequestStates.success &&
            state.couponMessage != null) {
          context.showCustomSnackBar(
              type: SnackBarType.success, message: state.couponMessage!);
        } else if (state.status == RequestStates.failure &&
            state.couponError != null) {
          context.showCustomSnackBar(
              type: SnackBarType.error, message: state.couponError!);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            title: 'Promo Code',
            showActionButton: false,
          ),
          SizedBox(height: AppSizes.spaceBtwItems / 2.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _couponController,
                  decoration: const InputDecoration(
                    hintText: 'Enter coupon code',
                  ),
                ),
              ),
              BlocBuilder<CartBloc, CartStates>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) => TextButton(
                  onPressed: state.status == RequestStates.loading
                      ? null
                      : _applyCoupon,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
          BlocBuilder<CartBloc, CartStates>(
            buildWhen: (previous, current) =>
                previous.couponDiscount != current.couponDiscount,
            builder: (context, state) {
              final discount = state.couponDiscount;
              if (discount == null || discount <= 0) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.only(top: AppSizes.sm / 2.h),
                child: Text(
                  'Coupon applied — you saved EGP $discount',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.success),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
