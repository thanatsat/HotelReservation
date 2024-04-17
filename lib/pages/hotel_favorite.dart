import 'package:flutter/material.dart';
import 'package:test/theme/color.dart';
import 'package:test/utils/data.dart';

class FavoriteHotelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Filter the list of features to get only the favorited ones
    List favoriteHotels =
        features.where((hotel) => hotel["is_favorited"]).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Hotels"),
        backgroundColor: AppColor.appBarColor,
      ),
      body: favoriteHotels.isEmpty
          ? Center(
              child: Text("You haven't favorited any hotels yet."),
            )
          : ListView.builder(
              itemCount: favoriteHotels.length,
              itemBuilder: (context, index) {
                return _buildFeatureItem(favoriteHotels[index]);
              },
            ),
    );
  }

  Widget _buildFeatureItem(Map hotel) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
            child: Image.network(
              hotel["image"],
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel["name"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  hotel["location"],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
