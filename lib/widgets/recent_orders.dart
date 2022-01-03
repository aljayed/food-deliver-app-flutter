import 'package:flutter/material.dart';
import 'package:food_delivery_project/data/data.dart';
import 'package:food_delivery_project/models/order.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({Key? key}) : super(key: key);

  _recentOrderSection(BuildContext context, Order order) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Colors.blueGrey[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    height: 100.0,
                    width: 100.0,
                    image: AssetImage(order.food.imageUrl),
                    //alternatively we can use AssetImage(order.food.imageUrl)
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        order.food.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.restaurant.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        order.date,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 48,
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () { },
              icon: Icon(Icons.add),
              color: Colors.white,
              iconSize: 30,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
            child: Text(
              'Recent Orders',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 24.0,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: currentUser.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  Order order = currentUser.orders[index];
                  return _recentOrderSection(context, order);
                }),
          )
        ],
      );
  }
}
