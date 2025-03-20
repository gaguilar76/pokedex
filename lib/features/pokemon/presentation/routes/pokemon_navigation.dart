import 'package:get/get.dart';

import 'package:pokedex_app/features/pokemon/presentation/pages/pokemon_home_page.dart';

class PokemonRoutes {
  static final String homePage = '/home_page';
  static final String detailPage = '/detak_page';
}

class PokemonPages {
  static final pages = [
    GetPage(
      name: PokemonRoutes.homePage, 
      page: () => PokemonHomePage(),
    ),
    GetPage(
      name: PokemonRoutes.detailPage, 
      page: () => PokemonHomePage(),
    )
  ];
}