import 'package:dartz/dartz.dart';

import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon_type.dart';

abstract class PokemonsRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemons([int offset, int limit]);
  Future<Either<Failure, List<PokemonType>>> getPokemonsType([int offset=0, int limit=30]);
  Future<Either<Failure, List<Pokemon>>> searchPokemonsByName(String name);
  Future<Either<Failure, List<Pokemon>>> filterPokemonsByType(String typeName);
  Future<Either<Failure, List<Pokemon>>> getPokemonsLocal();
  Future<Either<Failure, List<PokemonType>>> getPokemonsTypeLocal();
}