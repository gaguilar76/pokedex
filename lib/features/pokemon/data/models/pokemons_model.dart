
import 'package:pokedex_app/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemons.dart';

class PokemonsModel extends Pokemons {
  PokemonsModel({required super.count, required super.next, required super.previous, required super.results});

  factory PokemonsModel.fromJson(json) {
    return PokemonsModel(
      count: json['count'] ?? 0, 
      next: json['next'] ?? '', 
      previous: json['previous'] ?? '',  
      results: json['results'] == null ? [] : List<ResultModel>.from(json['results'].map((x) => ResultModel.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((e) => ResultModel.fromEntity(e).toJson()).toList(),
    };
  }

  factory PokemonsModel.fromEntity(Pokemons pokemons) {
    return PokemonsModel(
      count: pokemons.count, 
      next: pokemons.next, 
      previous: pokemons.previous, 
      results: pokemons.results);
  }
}