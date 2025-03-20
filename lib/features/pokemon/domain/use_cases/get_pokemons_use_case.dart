import 'package:dartz/dartz.dart';

import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/core/utils/utils_services.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_app/features/pokemon/domain/repositories/pokemons_repository.dart';

class GetPokemonsUseCase {
  final PokemonsRepository repository;

  GetPokemonsUseCase({required this.repository});

  Future<Either<Failure, List<Pokemon>>> call([int offset = 0, int limit = 20]) async {
    final bool hasInternet = await UtilsServices.hasInternet();
    if (hasInternet) {
      return repository.getPokemons(offset, limit);
    } else {
      return repository.getPokemonsLocal();
    }
  }

}