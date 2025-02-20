import 'package:get/get.dart';

import 'package:pokedex_app/features/pokemon/presentation/controllers/pokemon_controller.dart';

class PokemonBinding implements Bindings {
  @override
  dependencies() {
      Get.put(PokemonController());
    }
}