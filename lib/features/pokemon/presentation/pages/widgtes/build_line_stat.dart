import 'package:flutter/material.dart';
import 'package:pokedex_app/core/utils/utils_app.dart';
import 'package:pokedex_app/core/utils/utils_theme.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

class BuildLineStat extends StatelessWidget {
  final Stat stat;
  final String pokemonColor;

  const BuildLineStat({super.key, required this.stat, required this.pokemonColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                border: Border(right: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),              
            ),
            width: 50,
            child: Text(UtilsApp.getPokemonStats(stat.stat.name),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: UtilsTheme.getPokemonColor(pokemonColor),
                ),
                textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 30,
            child: Text(
              stat.baseStat.toString().padLeft(3, '0'),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: stat.baseStat / 100, 
              backgroundColor: UtilsTheme.getPokemonColor(pokemonColor).withValues(alpha: 0.1),
              color: UtilsTheme.getPokemonColor(pokemonColor),
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      
      ),
    );
  }
}