

import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

class Pokemons {
  final int count;
  final String next;
  final String previous;
  final List<Result> results;

  Pokemons({required this.count, required this.next, required this.previous, required this.results});
}