import 'package:dartz/dartz.dart';

import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/core/utils/utils_services.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon_type.dart';
import 'package:pokedex_app/features/pokemon/domain/repositories/pokemons_repository.dart';

class PokemonUseCases {
  final PokemonsRepository repository;

  PokemonUseCases({required this.repository});

  Future<Either<Failure, List<Pokemon>>> getPokemons([int offset = 0, int limit = 20]) async {
    final bool hasInternet = await UtilsServices.hasInternet();
    if (hasInternet) {
      return repository.getPokemons(offset, limit);
    } else {
      return repository.getPokemonsLocal();
    }
  }

  Future<Either<Failure, List<Pokemon>>> searchPokemonsByName(String name) {
    return repository.searchPokemonsByName(name);
  }

  Future<Either<Failure, List<Pokemon>>> filterPokemonsByType(String typeName) {
    return repository.filterPokemonsByType(typeName);
  }

  Future<Either<Failure, List<PokemonType>>> getPokemonsType() async {
    final bool hasInternet = await UtilsServices.hasInternet();
    if (hasInternet) {
      return repository.getPokemonsType();
    } else {
      return repository.getPokemonsTypeLocal();
    }
  }




}