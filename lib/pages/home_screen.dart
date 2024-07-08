import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';
import '../service/restaurant_service.dart';
import 'restaurant_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final restaurantService = Provider.of<RestaurantService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authService.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 14),
              markers: restaurantService.restaurants
                  .map((restaurant) => Marker(
                        markerId: MarkerId(restaurant.id),
                        position:
                            LatLng(restaurant.latitude, restaurant.longitude),
                        infoWindow: InfoWindow(title: restaurant.name),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RestaurantDetailScreen(
                                    restaurant: restaurant))),
                      ))
                  .toSet(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: restaurantService.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurantService.restaurants[index];
                return ListTile(
                  title: Text(restaurant.name),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              RestaurantDetailScreen(restaurant: restaurant))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
