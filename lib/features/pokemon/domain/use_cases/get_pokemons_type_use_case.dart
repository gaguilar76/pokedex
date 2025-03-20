import 'package:dartz/dartz.dart';

import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/core/utils/utils_services.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon_type.dart';
import 'package:pokedex_app/features/pokemon/domain/repositories/pokemons_repository.dart';

class GetPokemonsTypeUseCase {
  final PokemonsRepository repository;

  GetPokemonsTypeUseCase({required this.repository});

  Future<Either<Failure, List<PokemonType>>> call() async {
    final bool hasInternet = await UtilsServices.hasInternet();
    if (hasInternet) {
      return repository.getPokemonsType();
    } else {
      return repository.getPokemonsTypeLocal();
    }
  }


}
