
import 'package:flutter/material.dart';

import '../service/restaurant_service.dart';


class PaymentScreen extends StatelessWidget {
  final Restaurant restaurant;

  PaymentScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Center(
        child: ElevatedButton(
          // onPressed: () => initiatePayment(),
          onPressed: () => (){},
          child: Text('Pay Now'),
        ),
      ),
    );
  }

  // void initiatePayment() {
  //   StripePayment.setOptions(
  //     StripeOptions(
  //       publishableKey: "YOUR_PUBLISHABLE_KEY",
  //       merchantId: "YOUR_MERCHANT_ID",
  //       androidPayMode: 'test',
  //     ),
  //   );

  //   StripePayment.paymentRequestWithCardForm(
  //     CardFormPaymentRequest(),
  //   ).then((paymentMethod) {
  //     // Handle payment method and complete the payment process
  //     print("Payment Method: ${paymentMethod.id}");
  //   }).catchError((e) {
  //     print("Error: $e");
  //   });
  // }
}
