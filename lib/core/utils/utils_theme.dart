import 'dart:math';

import 'package:flutter/material.dart';

class UtilsTheme {

  static Color getPokemonColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case "black":
        return Colors.black;
      case "blue":
        return Colors.blue;
      case "brown":
        return Colors.brown;
      case "gray":
        return Colors.grey;
      case "green":
        return Colors.green;
      case "pink":
        return Colors.pink;
      case "purple":
        return Colors.purple;
      case "red":
        return Colors.red;
      case "white":
        return Colors.white;
      case "yellow":
        return Colors.yellow;
      default:
        return Colors.grey; // Color por defecto si no coincide
    }
  }

  static Color generateRandomColor() {
    Random random = Random();
    int r = random.nextInt(200); 
    int g = random.nextInt(200);
    int b = random.nextInt(200);    
    return Color.fromARGB(255, r, g, b);
  }

}