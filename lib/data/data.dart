import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> tranjectionData = [
  {
    "icon": const Icon(Icons.food_bank, color: Colors.white), // Food icon
    "color": Colors.yellow[700],
    "name": "Food",
    "totalAmount": "-\₹45.00",
    "date": "Today",
  },
  {
    "icon": const Icon(Icons.shopping_bag, color: Colors.white), // Food icon
    "color": Colors.purple,
    "name": "Shopping",
    "totalAmount": "-\₹280.00",
    "date": "Today",
  },
  {
    "icon": const Icon(
      Icons.health_and_safety,
      color: Colors.white,
    ), // Food icon
    "color": Colors.green,
    "name": "Health",
    "totalAmount": "-\₹73.00",
    "date": "Yeasterday",
  },
  {
    "icon": const Icon(Icons.flight, color: Colors.white), // Food icon
    "color": Colors.blue,
    "name": "Travel",
    "totalAmount": "-\₹73.00",
    "date": "Yeasterday",
  },
];
