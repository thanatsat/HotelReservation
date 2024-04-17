// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/feature_details.dart';
import 'package:test/theme/color.dart';
import 'package:test/utils/data.dart';
import 'package:test/widgets/city_item.dart';
import 'package:test/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: _builAppBar(),
          ),
          SliverToBoxAdapter(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _builAppBar() {
    return Row(
      children: [
        Icon(
          Icons.place_outlined,
          color: AppColor.labelColor,
          size: 20,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          "Khao yai",
          style: TextStyle(
            color: AppColor.darker,
            fontSize: 13,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "The Best Hotel Rooms",
              style: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          _buildCities(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "Featured",
              style: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          _buildFeatured(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor),
                ),
              ],
            ),
          ),
          _getRecommend(),
        ],
      ),
    );
  }

  _buildFeatured() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        features.length,
        (index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FeatureDetailsPage(feature: features[index]),
              ),
            );
          },
          child: FeatureItem(
            data: features[index],
            onTapFavorite: () {
              setState(() {
                features[index]["is_favorited"] =
                    !features[index]["is_favorited"];
              });
            },
          ),
        ),
      ),
    );
  }

  void _showFeatureDetails(Map feature) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature["name"],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Price: ${feature["price"]}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "Type: ${feature["type"]}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "Location: ${feature["location"]}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "Description: ${feature["description"]}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  _getRecommend() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          recommends.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RecommendItem(
              data: recommends[index],
            ),
          ),
        ),
      ),
    );
  }

  _buildCities() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          cities.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CityItem(
              data: cities[index],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final Map data;
  final VoidCallback onTapFavorite;

  const FeatureItem({
    Key? key,
    required this.data,
    required this.onTapFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  data["image"],
                  height: 180, // Set desired height
                  fit: BoxFit.cover, // Fill the entire space
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["name"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data["location"],
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
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                data["is_favorited"] ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: onTapFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
