import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pokedex_app/features/pokemon/presentation/controllers/pokemon_controller.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find(); 
  final ctl = Get.put(PokemonController());

  final _box = GetStorage(); 
  final _key = 'isDarkMode'; 

  bool get isDarkMode => _box.read(_key) ?? false;

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    bool newMode = !isDarkMode;
    _box.write(_key, newMode);
    Get.changeThemeMode(newMode ? ThemeMode.dark : ThemeMode.light);
    ctl.update();
  }
}