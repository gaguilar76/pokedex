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
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageSize = constraints.maxWidth * 0.6;

        return Container(
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
          child: Stack(
            children: [
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
                top: constraints.maxHeight * 0.4,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
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
                        style: const TextStyle(
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
                top: constraints.maxHeight * 0.10, 
                left: constraints.maxWidth * 0.20,
                child: CachedNetworkImage(
                  height: imageSize,
                  width: imageSize,
                  imageUrl: pokemon.imageUrl,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    pokeballSvg,
                    height: 20,
                    width: 20,
                  ),
                  fit: BoxFit.contain,
                ),
              ),  
            ],
          ),
        );
      }
    );
    /*Container(
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
      child: Stack(
        children: [
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
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
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
          top: 10,
          left: 15,
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
      ),
    );*/
  }
}