

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_app/core/utils/images_app.dart';
import 'package:pokedex_app/core/utils/strings_app.dart';
import 'package:pokedex_app/core/utils/utils_app.dart';
import 'package:pokedex_app/core/utils/utils_theme.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

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
                      child: Container(
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
                      )
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        //color: Colors.pink,
                        child: Column(
                            children: [
                              Text('About',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: UtilsTheme.getPokemonColor(pokemon.color),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  weightSvg,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Text('${pokemon.weight.toString()} kg')
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(weightStr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                              ),
                                            ),
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
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    straightenSvg,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  Text('${pokemon.height.toString()} m')
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(straightenStr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                                ),
                                              ),
                                            ],
                                          ),   
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        
                                      ),
                                    ),
                                    
                                  ],
                                )
                              ),
                              
                            ],
                          ),
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.amber,
                      )
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        color: Colors.greenAccent,
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
              child: Container(
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
                          fontFamily: 'Poppins',
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

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                UtilsApp.capitalizeEachWord(pokemon.name),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "#${pokemon.id}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
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

  Widget buildInfoCard() {
    return Container(
      //width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
    );
  }




}