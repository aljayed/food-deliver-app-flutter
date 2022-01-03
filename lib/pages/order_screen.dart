import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_project/data/data.dart';
import 'package:food_delivery_project/models/restaurant.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Restaurant restaurant = Get.arguments;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: restaurant.imageUrl,
                child: Image(
                    image: AssetImage(restaurant.imageUrl),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(Icons.favorite),
                        color: !isFavorite ? Colors.white : Colors.yellow[400],
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.2 miles away',
                          style: TextStyle(
                            fontSize: 18,

                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${restaurant.rating.toString()}.0'
                        )
                      ],
                    ),
                    
                  ]
                ),
          )
        ],
      ),
    );
  }
}
