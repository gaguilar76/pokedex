import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pokedex_app/core/utils/images_app.dart';
import 'package:pokedex_app/core/utils/utils_app.dart';
import 'package:pokedex_app/core/utils/utils_theme.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_app/features/pokemon/presentation/pages/widgtes/build_about_pokemon.dart';
import 'package:pokedex_app/features/pokemon/presentation/pages/widgtes/build_line_stat.dart';
import 'package:pokedex_app/features/pokemon/presentation/pages/widgtes/build_types_pokemon.dart';

class PokemonInfoPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInfoPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: UtilsTheme.getPokemonColor(pokemon.color),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 90,
              child: Opacity(
                opacity: 0.2,
                child: SvgPicture.asset(
                          pokeballSvg,
                          height: 200,
                          width: 200,
                        ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              top: 340,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Expanded(
                      flex: 2,
                      child: BuildTypesPokemon(pokemon: pokemon)
                    ),
                    Expanded(
                      flex: 5,
                      child: BuildAboutPokemon(pokemon: pokemon)
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(pokemon.description,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('Base Stats',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: UtilsTheme.getPokemonColor(pokemon.color),
                              ),
                            ),
                            for (var i = 0; i < pokemon.stats.length; i++) 
                               BuildLineStat(stat: pokemon.stats[i], pokemonColor: pokemon.color), 
                          ],
                        ),
                      )
                    ),
                  ],
                )
              ),
            ),
            Positioned(
              left: 5,
              right: 5,
              top: 40,
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      UtilsApp.capitalizeEachWord(pokemon.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "#${pokemon.id}",
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 5,
              right: 5,
              top: 220,
              height: 200,
              child: Container(
                child: buildPokemonImage(),
              ),
            ),            
          ],
        ),
      ),
    );
  }

  Widget buildPokemonImage() {
    return CachedNetworkImage(
              imageUrl: pokemon.imageUrl,
              placeholder: (context, url) =>
                  CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  SvgPicture.asset(
                        pokeballSvg,
                        height: 20,
                        width: 20,
                      ),
              fit: BoxFit.fitHeight
            );
  }

}



