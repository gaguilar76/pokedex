import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({ required super.id, 
                 required super.name, 
                 required super.imageUrl,
                 required super.color,
                 required super.description,
                 required super.abilities, 
                 required super.stats, 
                 required super.baseExperience, 
                 required super.height, 
                 required super.weight, 
                 required super.types,
                 required super.moves});

  factory PokemonModel.fromJson(json, jsonSpecies) {
    String description = '';
    final descriptions = jsonSpecies['flavor_text_entries'];
    for (var entry in descriptions) {
      if (entry['language']['name'] == 'en') {
        description = entry['flavor_text'].replaceAll('\n', ' ').replaceAll('\f', ' ');
        break;
      }
    }    

    return PokemonModel(
      id: json['id'], 
      name: json['name'], 
      imageUrl: json['sprites']['front_default'],  
      color: jsonSpecies['color']['name'],  
      description: description,
      abilities: json["abilities"] == null ? [] : List<AbilityModel>.from(json['abilities'].map((x) => AbilityModel.fromJson(x))),
      stats: json["stats"] == null ? [] : List<StatModel>.from(json["stats"].map((x) => StatModel.fromJson(x))),
      baseExperience: json['base_experience'], 
      height: json["height"], 
      weight: json["weight"], 
      types: json["types"] == null ? [] : List<TypeModel>.from(json["types"].map((x) => TypeModel.fromJson(x))),
      moves: json["moves"] == null ? [] : List<MoveModel>.from(json["moves"].map((x) => MoveModel.fromJson(x))).take(2).toList(),
      );
  }

  factory PokemonModel.fromJsonLocal(json) {
    return PokemonModel(
      id: json['id'], 
      name: json['name'], 
      imageUrl: json['sprites']['front_default'],  
      color: json['color'],
      description: json['description'],  
      abilities: json["abilities"] == null ? [] : List<AbilityModel>.from(json['abilities'].map((x) => AbilityModel.fromJson(x))),
      stats: json["stats"] == null ? [] : List<StatModel>.from(json["stats"].map((x) => StatModel.fromJson(x))),
      baseExperience: json['base_experience'], 
      height: json["height"], 
      weight: json["weight"], 
      types: json["types"] == null ? [] : List<TypeModel>.from(json["types"].map((x) => TypeModel.fromJson(x))),
      moves: json["moves"] == null ? [] : List<MoveModel>.from(json["moves"].map((x) => MoveModel.fromJson(x)))
      );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprites': {
        'front_default' : imageUrl
      },
      'color': color,
      'description': description,
      'abilities': abilities.map((e) => AbilityModel.fromEntity(e).toJson()).toList(),
      'stats': stats.map((e) => StatModel.fromEntity(e).toJson()).toList(),
      'base_experience': baseExperience,
      'height': height,
      'weight': weight,
      'types': types.map((e) => TypeModel.fromEntity(e).toJson()).toList(),
      'moves': moves.map((e) => MoveModel.fromEntity(e).toJson()).toList(),
    };
  }

  factory PokemonModel.fromEntity(Pokemon pokemon) {
    return PokemonModel(  id: pokemon.id, 
                          name: pokemon.name, 
                          imageUrl: pokemon.imageUrl, 
                          color: pokemon.color,
                          description: pokemon.description,
                          abilities: pokemon.abilities, 
                          stats: pokemon.stats, 
                          baseExperience: pokemon.baseExperience, 
                          height: pokemon.height, 
                          weight: pokemon.weight, 
                          types: pokemon.types,
                          moves: pokemon.moves);
  }
}


class AbilityModel extends Ability {
  AbilityModel({required super.ability, required super.isHidden, required super.slot});

  factory AbilityModel.fromJson(json)  {
    return AbilityModel(
      ability: ResultModel.fromJson(json['ability']), 
      isHidden: json['is_hidden'], 
      slot: json['slot']);
  }

  Map<String, dynamic> toJson() {
    return {
      'ability': ResultModel.fromEntity(ability).toJson(),
      'is_hidden': isHidden,
      'slot': slot,
    };
  }

  factory AbilityModel.fromEntity(Ability ability) {
    return AbilityModel(  ability: ability.ability, 
                          isHidden: ability.isHidden, 
                          slot: ability.slot);
  }

}

class StatModel extends Stat {
  StatModel({required super.baseStat, required super.stat});

  factory StatModel.fromJson(json)  {
    return StatModel(
      baseStat: json['base_stat'],
      stat: ResultModel.fromJson(json['stat']));
  }

  Map<String, dynamic> toJson() {
    return {
      'base_stat' : baseStat,
      'stat': ResultModel.fromEntity(stat).toJson(),
    };
  }

  factory StatModel.fromEntity (Stat stat) {
    return StatModel( baseStat: stat.baseStat, 
                      stat: stat.stat);
  }

}

class ResultModel extends Result {
  ResultModel({required super.name, required super.url});

  factory ResultModel.fromJson(json)  {
    return ResultModel(
      name: json['name'],
      url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'url': url
    };
  }

  factory ResultModel.fromEntity (Result result) {
    return ResultModel(  name: result.name, 
                          url: result.url);
  }
}

class TypeModel extends Type {
  TypeModel({required super.slot, required super.type});

  factory TypeModel.fromJson(json) { 
      return TypeModel (
        slot: json['slot'],
        type: ResultModel.fromJson(json['type'])
      );
  }

  Map<String, dynamic> toJson() {
      return {
        'slot': slot,
        'type': ResultModel.fromEntity(type).toJson(),
      };
  }    

  factory TypeModel.fromEntity(Type type) {
    return TypeModel( slot: type.slot, 
                      type: type.type);
  }
}


class MoveModel extends Move {
  MoveModel({required super.name});

  factory MoveModel.fromJson(json) { 
      return MoveModel (
        name: json['move']['name']
      );
  }

  Map<String, dynamic> toJson() {
      return {
      'move': {
          'name' : name
        },
      };
  }    

  factory MoveModel.fromEntity(Move type) {
    return MoveModel( name: type.name);
  }
}
