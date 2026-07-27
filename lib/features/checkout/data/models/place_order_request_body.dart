class PlaceOrderRequestBody {
  final String cartId;
  final String details;
  final String phone;
  final String city;

  PlaceOrderRequestBody({
    required this.cartId,
    required this.details,
    required this.phone,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
        'shippingAddress': {
          'details': details,
          'phone': phone,
          'city': city,
        },
      };
}
