import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/core/source/api.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon_type_model.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemons_model.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon_type.dart';


abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getPokemons([int offset, int limit]);
  Future<List<PokemonType>> getPokemonTypes([int offset, int limit]);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {

  final Dio dio = Dio();
  List<PokemonModel> pokemons = [];
  List<PokemonTypeModel> pokemonsType = [];
  

  Future<PokemonModel> getPokemonByName(String name) async {
    try {
      Response response = await dio.get('${API.baseUrl}/pokemon/$name').timeout(const Duration(seconds: 10));
      return PokemonModel.fromJson(response.data);
    } catch (error) {
      debugPrint(error.toString());
      throw ServerFailure();
    }
  }


  @override
  Future<List<PokemonModel>> getPokemons([int offset=0, int limit=20]) async {
    try {
        pokemons = [];
        var box = await Hive.openBox('pokemons_cache');
        Response response =
            await dio.get('${API.baseUrl}/pokemon?limit=$limit&offset=$offset').timeout(const Duration(seconds: 10));
        PokemonsModel pokemonsResponse = PokemonsModel.fromJson(response.data);

        if (pokemonsResponse.results.isNotEmpty) {
          for (var element in pokemonsResponse.results) {
            if (box.containsKey(element.name)) {
              PokemonModel pokemon = PokemonModel.fromJson(box.get(element.name));
              pokemons.add(pokemon);
            } else {
              PokemonModel pokemon = await getPokemonByName(element.name);
              await box.put(element.name, pokemon.toJson());
              pokemons.add(pokemon);
            }
          }
        }
      
      return pokemons;
    } catch (error) {
      debugPrint(error.toString());
      throw ServerFailure();
    }
  }
  
  
  @override
  Future<List<PokemonType>> getPokemonTypes([int offset=0, int limit=30]) async {
    try {
        pokemonsType = [];
        var box = await Hive.openBox('type_cache');
        Response response =
            await dio.get('${API.baseUrl}type?limit=$limit&offset=$offset').timeout(const Duration(seconds: 10));

        if (response.data['results'].isNotEmpty) {
          pokemonsType = List<PokemonTypeModel>.from(response.data['results'].map((x) => PokemonTypeModel.fromJson(x))).toList();
          final jsonString = jsonEncode(pokemonsType.map((t) => t.toJson()).toList());
          await box.put('pokemon_types', jsonString);
        }
      return pokemonsType;
    } catch (error) {
      debugPrint(error.toString());
      throw ServerFailure();
    }
  }

  
}

