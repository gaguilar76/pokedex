import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pokedex_app/core/utils/strings_app.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon_type.dart';
import 'package:pokedex_app/features/pokemon/domain/use_cases/pokemon_use_cases.dart';
import 'package:pokedex_app/features/pokemon/presentation/bindigns/pokemon_binding.dart';
import 'package:pokedex_app/features/pokemon/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedex_app/main.dart';

class PokemonController extends GetxController {
  final loading = false.obs;
  final errorLoaded = false.obs;
  final listPokemon = <Pokemon>[].obs;
  final listPokemonType = <PokemonType>[].obs;
  List<Pokemon> listPokemonAux = [];
  int offset = 0;
  final int limit = 20; // Tamaño de página
  final ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();
  final PokemonUseCases useCases = Get.put(PokemonUseCases(repository: pokemonRepositoryImpl));
  final typeSelected = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
  }
  

  Future<void> loadPokemons() async {
    if (loading.value) return;
    loading.value = true;
    try {
      typeSelected.value = '';
      searchController.text = '';
      var result = await useCases.getPokemons(offset, limit);
      result.fold(
          (failure) {
            errorLoaded.value = true;
          },
          (pokemons) {
            errorLoaded.value =false;
            listPokemon.addAll(pokemons);
            listPokemonAux = List.from(listPokemon.value);
            offset += limit;
          },
        );

      final result2 = await useCases.getPokemonsType();
      result2.fold(
          (failure) {
            errorLoaded.value = true;
          },
          (pokemonsType) {
            errorLoaded.value =false;
            listPokemonType.addAll(pokemonsType.toSet().toList());
          },
        );
    } finally {
      loading.value = false;
    }
  } 

  reorderPokemons(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--; 

    final movedPokemon = listPokemon.removeAt(oldIndex);
    listPokemon.insert(newIndex, movedPokemon);
  }

  searchPokemonByName() {
    if (loading.value) return;
    loading.value = true;
    try {
      typeSelected.value = '';      
      final valueSearch = searchController.text.trim();
      listPokemon.value = List.from(listPokemonAux);
      if (valueSearch != '' ) {
            List<Pokemon> result = listPokemon.value.where((item) {
              return ((item.name
                      .trim()
                      .toLowerCase()
                      .contains(valueSearch.trim().toLowerCase())));
            }).toList();     
            listPokemon.value = List.from(result);
      }       
    } finally {
      loading.value = false;
    }
  }
  
  List<DropdownMenuItem<dynamic>> get typesPokeon {
    List<DropdownMenuItem<dynamic>> menuItems = [];
    menuItems.add(DropdownMenuItem(value: '', child: Text(allType)));

    final uniqueTypes = listPokemonType.value.map((e) => e.name.toString()).toSet();

    for (var type  in uniqueTypes) {
      menuItems.add(DropdownMenuItem(
          value: type,
          child: Text(
            type,
            overflow: TextOverflow.ellipsis,
          )));
    }
    return menuItems;
  }

  filterPokemonByType() {
    if (loading.value) return;
    loading.value = true;
    try {
      searchController.text = '';
      final valueFilter = typeSelected.value;
      listPokemon.value = List.from(listPokemonAux);
      if (valueFilter != '') {
            List<Pokemon> result = listPokemon.value.where((item) {
              return ((item.types.any((t) => t.type.name.trim()
                      .toLowerCase()
                      .contains(valueFilter.trim().toLowerCase()))
                      ));
            }).toList();     
            listPokemon.value = List.from(result);
      }       
    } finally {
      loading.value = false;
    }
  }

  showDetailPokemon(Pokemon pokemon) {
    Get.to(
      () => PokemonDetailPage(pokemon: pokemon),
      binding: PokemonBinding(),
      transition: Transition.fadeIn,
      duration: Duration(milliseconds: 600),
    );
  }

}