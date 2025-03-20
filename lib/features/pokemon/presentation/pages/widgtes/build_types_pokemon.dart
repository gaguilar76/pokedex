import 'package:flutter/material.dart';

import 'package:pokedex_app/core/utils/utils_app.dart';
import 'package:pokedex_app/core/utils/utils_theme.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

class BuildTypesPokemon extends StatelessWidget {
  const BuildTypesPokemon({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < pokemon.types.length; i++) 
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: UtilsTheme.generateRandomColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(UtilsApp.capitalizeEachWord(pokemon.types[i].type.name),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                 ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}