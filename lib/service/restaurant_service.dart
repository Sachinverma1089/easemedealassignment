import 'package:flutter/material.dart';

class Restaurant {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Restaurant(this.id, this.name, this.latitude, this.longitude);
}

class RestaurantService with ChangeNotifier {
  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  Future<void> getNearbyRestaurants(double latitude, double longitude) async {
    // Fetch nearby restaurants from an API or database and update _restaurants
    // Example data:
    _restaurants = [
      Restaurant('1', 'Restaurant A', 37.7749, -122.4194),
      Restaurant('2', 'Restaurant B', 37.7849, -122.4094),
    ];
    notifyListeners();
  }
}
