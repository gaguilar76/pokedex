import 'package:dartz/dartz.dart';

import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:pokedex_app/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon_type.dart';
import 'package:pokedex_app/features/pokemon/domain/repositories/pokemons_repository.dart';

class PokemonRepositoryImpl implements PokemonsRepository {

  final PokemonLocalDataSource pokemonLocalDataSource;
  final PokemonRemoteDataSource pokemonRemoteDataSource;

  PokemonRepositoryImpl(
    {required this.pokemonLocalDataSource, 
    required this.pokemonRemoteDataSource}
  );

  @override
  Future<Either<Failure, List<Pokemon>>> filterPokemonsByType(String typeName) async {
    try {
      final List<Pokemon> resp = await pokemonLocalDataSource.filterPokemonsByType(typeName);
      return Right(resp);
    } on LocalFailure {
      return left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemons([int offset=0, int limit=20]) async {
    try {
      final List<Pokemon> resp = await pokemonRemoteDataSource.getPokemons(offset, limit);
      return Right(resp);
    } on ServerFailure {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> searchPokemonsByName(String name) async {
    try {
      final List<Pokemon> resp = await pokemonLocalDataSource.searchPokemonsByName(name);
      return Right(resp);
    } on LocalFailure {
      return left(LocalFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonsLocal() async {
    try {
      final List<Pokemon> resp = await pokemonLocalDataSource.getPokemonsLocal();
      return Right(resp);
    } on LocalFailure {
      return left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<PokemonType>>> getPokemonsType([int offset=0, int limit=30]) async {
    try {
      final List<PokemonType> resp = await pokemonRemoteDataSource.getPokemonTypes(offset, limit);
      return Right(resp);
    } on ServerFailure {
      return left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<PokemonType>>> getPokemonsTypeLocal() async {
    try {
      final List<PokemonType> resp = await pokemonLocalDataSource.getPokemonsTypeLocal();
      return Right(resp);
    } on LocalFailure {
      return left(LocalFailure());
    }
  }

}