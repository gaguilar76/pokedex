

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon_type_model.dart';

abstract class PokemonLocalDataSource {
  Future<List<PokemonModel>> getPokemonsLocal();
  Future<List<PokemonTypeModel>> getPokemonsTypeLocal();
}


class HivePokemonLocalDataSourceImpl implements PokemonLocalDataSource {

 
  @override
  Future<List<PokemonModel>> getPokemonsLocal() async {
    try {
      var box = await Hive.openBox('pokemons_cache');
      final allPokemons = box.values.map((p) => PokemonModel.fromJsonLocal(p)).toList();
      allPokemons.sort((a, b) => a.id.compareTo(b.id));
      return allPokemons;
    } catch (error) {
      debugPrint(error.toString()); 
      throw LocalFailure();
    }
  }
  
  @override
  Future<List<PokemonTypeModel>> getPokemonsTypeLocal() async {
    try {
      var box = await Hive.openBox('type_cache');
      final jsonString = box.get('pokemon_types');
      if (jsonString != null) {
        List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => PokemonTypeModel.fromJson(json)).toList();
      }
      return [];
    } catch (error) {
      debugPrint(error.toString()); 
      throw LocalFailure();
    }
  }

}