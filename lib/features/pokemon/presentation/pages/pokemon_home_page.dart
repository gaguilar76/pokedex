import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pokedex_app/core/utils/images_app.dart';
import 'package:pokedex_app/core/utils/strings_app.dart';
import 'package:pokedex_app/features/pokemon/presentation/controllers/pokemon_controller.dart';
import 'package:pokedex_app/core/widgets/search_text_field.dart';
import 'package:pokedex_app/features/pokemon/presentation/pages/widgtes/pokemon_card.dart';

class PokemonHomePage extends StatefulWidget {
  const PokemonHomePage({super.key});

  @override
  State<PokemonHomePage> createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {
  final ctl = Get.put(PokemonController());
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Liberar el controlador
    super.dispose();
  }

  _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ctl.loadPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 20, top: 60, bottom: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        pokeballSvg,
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Pokédex',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: SearchTextField(
                        controller: ctl.searchController,
                        label: searchPokemon,
                        onChanged: (value) {
                          ctl.searchPokemonByName();
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showSortDialog(context, ctl);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Obx(() => Center(
                            child: SvgPicture.asset(
                              ctl.selectedOption.value == '0' 
                              ? tagSvg
                              : textSvg,
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              ctl.loading.value
                  ? Expanded(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Loading...',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          CircularProgressIndicator(),
                        ],
                      )),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                  controller: _scrollController,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, 
                                    childAspectRatio: 1, 
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemCount: ctl.listPokemon.value.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        ctl.showDetailPokemon(ctl.listPokemon[index]);
                                      },
                                      child: PokemonCard(
                                        pokemon: ctl.listPokemon.value[index],
                                       ),
                                    );
                                  },
                                ),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}

showSortDialog(BuildContext context, PokemonController ctl) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Stack(
        children: [
          Positioned(
            top: 80,
            right: 20,
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor:
                      Color.fromRGBO(220, 10, 45, 1), // Color de fondo
                  title: Text(
                    sortBy,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  content: Obx(
                    () => Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            title: Text(numberStr),
                            value: "0",
                            groupValue: ctl.selectedOption.value,
                            activeColor: Color.fromRGBO(220, 10, 45, 1),
                            onChanged: (value) {
                              setState(() {
                                ctl.setSortOptions(context, value);
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text(nameStr),
                            value: "1",
                            groupValue: ctl.selectedOption.value,
                            activeColor: Color.fromRGBO(220, 10, 45, 1),
                            onChanged: (value) {
                              setState(() {
                                ctl.setSortOptions(context, value);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
