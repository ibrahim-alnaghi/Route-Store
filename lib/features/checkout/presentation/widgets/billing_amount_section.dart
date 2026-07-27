import 'package:flutter/material.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key, required this.totalPrice});

  final num totalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Order Total',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'EGP $totalPrice',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
