import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_app/core/utils/images_app.dart';
import 'package:pokedex_app/core/utils/utils_app.dart';

import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(2, 2),
                ),
              ],
          ),
        ),
        Positioned(
          top: 5,
          right: 10,
          child: Text(
                "#${pokemon.id}",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        Positioned(
          top: 65,
          child: Container(
                  height: 55,
                  width: 126,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 239, 239, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        UtilsApp.capitalizeEachWord(pokemon.name),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        Positioned(
          top: 25,
          left: 25,
          child: CachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl: pokemon.imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            SvgPicture.asset(
                                  pokeballSvg,
                                  height: 20,
                                  width: 20,
                                ),
                        fit: BoxFit.contain),
        ),
      ],
    );
  }
}