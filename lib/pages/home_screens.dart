import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_project/data/data.dart';
import 'package:food_delivery_project/models/restaurant.dart';
import 'package:food_delivery_project/pages/order_screen.dart';
import 'package:food_delivery_project/widgets/recent_orders.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool clearEnabled = false;
  TextEditingController searchField = TextEditingController();
  int ratingNum = 3;
  bool isNewRestaurant = false;

  buildRestaurantsSection() {

    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      setState(() {
        isNewRestaurant = restaurant.rating <= 2 ? true : false;
      });
      restaurantList.add(
        GestureDetector(
        onTap: () {
          Get.to(OrderScreen(), arguments: restaurant);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1.0, color: Colors.grey[200]!)),
          child: Row(
            children: [
              ClipRRect(
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(
                    image: AssetImage(restaurant.imageUrl),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        restaurant.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        restaurant.address,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      isNewRestaurant
                          ? Text(
                              'New Restaurant',
                              style: TextStyle(fontSize: 18, color: Colors.lightGreen[700]),
                            )
                          : Row(
                              children: [
                                RatingWidget(
                                  ratingNum: ratingNum,
                                  restaurant: restaurant,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '(${restaurant.rating}.0)',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "1.2 miles away",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    });
    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {},
        ),
        title: Text('Local Food Delivery'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Cart (${currentUser.cart.length})",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ))
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: searchField,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 0.8,
                        color: Colors.grey,
                      )),
                  hintText: 'Search Food or Restaurants',
                  hintStyle: TextStyle(
                    overflow: TextOverflow.visible,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(17, 0, 10, 0),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: clearEnabled
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                searchField.clear();
                                clearEnabled = false;
                              });
                            },
                          )
                        : null,
                  )),
              maxLength: 100,
              onChanged: (value) {
                setState(() {
                  value.isNotEmpty ? clearEnabled = true : clearEnabled = false;
                });
              },
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                child: Text(
                  "Nearby Restaurants",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                      color: Colors.black),
                ),
              ),
              buildRestaurantsSection(),
            ],
          ),
        ],
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  RatingWidget({
    Key? key,
    required this.ratingNum,
    required this.restaurant,
  }) : super(key: key);

  late final int ratingNum;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 18,
      initialRating: restaurant.rating.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: 2),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        ratingNum = rating.toInt();
      },
    );
  }
}
