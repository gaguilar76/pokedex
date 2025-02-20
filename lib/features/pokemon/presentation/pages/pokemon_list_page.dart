import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pokedex_app/core/utils/images_app.dart';
import 'package:pokedex_app/core/utils/strings_app.dart';
import 'package:pokedex_app/features/pokemon/presentation/controllers/pokemon_controller.dart';
import 'package:pokedex_app/features/pokemon/presentation/controllers/theme_controller.dart';
import 'package:pokedex_app/core/widgets/drop_down.dart';
import 'package:pokedex_app/core/widgets/search_text_field.dart';


class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final ctl = Get.put(PokemonController());

  @override
  void initState() {
    super.initState();
    ctl.scrollController.addListener(() {
      if (ctl.scrollController.position.pixels >= ctl.scrollController.position.maxScrollExtent - 200) {
        ctl.loadPokemons(); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('Pokédex'),
        ),
        body: Obx(() => ctl.loading.value
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Loading...'),
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                  ],
                )
              )
              : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 600),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: IconButton(
                                key: ValueKey<bool>(ThemeController.to.isDarkMode),
                                icon: Icon(
                                  ThemeController.to.isDarkMode
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  size: 50,
                                ),
                                onPressed: ThemeController.to.toggleTheme,
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: SearchTextField(
                              controller: ctl.searchController,
                              label: searchPokemon,
                              onChanged: (value) {
                                ctl.searchPokemonByName();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: Select(
                              value: ctl.typeSelected.value == '' ? null : ctl.typeSelected.value,  
                              label: selectedType,
                              dataList: ctl.typesPokeon,
                              onChange: (v) async {
                                ctl.typeSelected.value = v;
                                ctl.filterPokemonByType();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ReorderableListView(
                      onReorder: (oldIndex, newIndex) => ctl.reorderPokemons(oldIndex, newIndex),
                      scrollController: ctl.scrollController,
                      children: [
                          for (int index = 0; index < ctl.listPokemon.value.length; index++)
                            GestureDetector(
                              key: ValueKey(ctl.listPokemon[index].id),
                              onTap: () {
                                ctl.showDetailPokemon(ctl.listPokemon[index]);
                              },
                              child: Card(
                                  elevation: 2,
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    title: Text(ctl.listPokemon[index].name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    ),
                                    subtitle: Text("Identifier: ${ctl.listPokemon[index].id}"),
                                    leading: CachedNetworkImage(
                                      height: 60,
                                      width: 60,
                                      imageUrl: ctl.listPokemon[index].imageUrl,
                                      placeholder: (context, url) => CircularProgressIndicator(), 
                                      errorWidget: (context, url, error) => Image.asset(pokemonPng), 
                                      fit: BoxFit.cover),
                                    trailing: Icon(Icons.move_up),
                                  ),
                                ),
                            ),
                          ],
                      ),
                    ),
                  ],
                )
            ),
      );
  }

}
