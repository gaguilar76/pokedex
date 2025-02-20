import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:pokedex_app/core/source/api.dart';
import 'package:pokedex_app/core/utils/images_app.dart';
import 'package:pokedex_app/features/pokemon/domain/entities/pokemon.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,)..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller, 
    curve: Curves.easeInOut);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.pokemon.name,
              style: TextStyle(
                  fontSize: 28,
                ),
               ),
              Center(
                child: ScaleTransition(
                  scale: _animation,
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: CachedNetworkImage(
                              imageUrl: '${API.spriteUrl}${widget.pokemon.id}.png',
                              placeholder: (context, url) => CircularProgressIndicator(), 
                              errorWidget: (context, url, error) => Image.asset(pokemonPng), 
                              fit: BoxFit.cover),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Height: ${widget.pokemon.height} cm',
                  style: TextStyle(
                      fontSize: 18,
                    ),
                 ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Weight: ${widget.pokemon.weight} kg',
                  style: TextStyle(
                      fontSize: 18,
                    ),
                 ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Base experience: ${widget.pokemon.baseExperience}',
                  style: TextStyle(
                      fontSize: 18,
                    ),
                 ),
              ),
              if (widget.pokemon.abilities.isNotEmpty)
                  Column(
                    children: [
          
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Abilities: ',
                            style: TextStyle(
                                fontSize: 18,
                              ),
                          ),
                        ),
          
                        for (int index = 0; index <  widget.pokemon.abilities.length; index++)
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(widget.pokemon.abilities[index].ability.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                    ),
                                ),
                          ),
                    ],
                  ),

              if (widget.pokemon.types.isNotEmpty)
                  Column(
                    children: [
          
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Types: ',
                            style: TextStyle(
                                fontSize: 18,
                              ),
                          ),
                        ),
          
                        for (int index = 0; index <  widget.pokemon.types.length; index++)
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(widget.pokemon.types[index].type.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                    ),
                                ),
                          ),
                    ],
                  ),                  

              if (widget.pokemon.stats.isNotEmpty)
                  Column(
                    children: [
          
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Stats: ',
                            style: TextStyle(
                                fontSize: 18,
                              ),
                          ),
                        ),
          
                        for (int index = 0; index <  widget.pokemon.stats.length; index++)
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(widget.pokemon.stats[index].stat.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                    ),
                                ),
                          ),
                    ],
                  ),                  
              
            ],
          ),
        ),
      ),
    );
  }
}