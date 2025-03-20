import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pokedex_app/core/utils/images_app.dart';
import 'package:pokedex_app/core/utils/strings_app.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

class AboutPokemon extends StatelessWidget {
  const AboutPokemon({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          weightSvg,
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 10),
                        Text('${(pokemon.weight / 100).toString()} kg')
                      ],
                    ),
                    Expanded(
                        child: Container()
                      ),   
                    Align(
                      alignment: Alignment.center,
                      child: Text(weightStr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),  
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            straightenSvg,
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 10),
                          Text('${(pokemon.height / 100).toString()} m')
                        ],
                      ),
                      Expanded(
                        child: Container()
                      ),   
                      Align(
                        alignment: Alignment.center,
                          child: Text(straightenStr,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                    ],
                  ),   
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    for (var i = 0; i < pokemon.moves.length; i++) 
                      Text(pokemon.moves[i].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                    Expanded(
                        child: Container()
                      ),   
                      Align(
                        alignment: Alignment.center,
                        child: Text(movesStr,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        ),
                      ),
                      SizedBox(height: 20),
                  ],
                )
              ),
            ),                            
        ],
      ),
    );
  }
}
