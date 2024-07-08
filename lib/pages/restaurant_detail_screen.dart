import 'package:easemydealassignment/pages/payment_screen.dart';
import 'package:flutter/material.dart';

import '../service/restaurant_service.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDetailScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PaymentScreen(restaurant: restaurant))),
          child: Text('Order Now'),
        ),
      ),
    );
  }
}
