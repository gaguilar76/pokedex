import 'package:pokedex_app/features/pokemon/domain/entities/pokemon_type.dart';

class PokemonTypeModel extends PokemonType {
  PokemonTypeModel({required super.name, required super.url});

  factory PokemonTypeModel.fromJson(json)  {
    return PokemonTypeModel(
      name: json['name'],
      url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'url': url
    };
  }

  factory PokemonTypeModel.fromEntity (PokemonType result) {
    return PokemonTypeModel(name: result.name, url: result.url);
  }

}