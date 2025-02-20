class Pokemon {
  final int id;  
  final String name;
  final String imageUrl;
  final List<Ability> abilities;
  final List<Stat> stats;
  final int baseExperience;
  final int height;
  final int weight;
  final List<Type> types;

  Pokemon({ required this.id, 
            required this.name, 
            required this.imageUrl, 
            required this.abilities, 
            required this.stats, 
            required this.baseExperience, 
            required this.height, 
            required this.weight, 
            required this.types });
}

class Ability {
  final Result ability;
  final bool isHidden;
  final int slot;

  Ability({required this.ability, required this.isHidden, required this.slot});

}

class Type {
  final int slot;
  final Result type;

  Type({required this.slot, required this.type});

}

class Stat {
  final int baseStat;
  final Result stat;

  Stat({required this.baseStat, required this.stat});

}


class Result {
  final String name;
  final String url;

  Result({required this.name, required this.url});

}

