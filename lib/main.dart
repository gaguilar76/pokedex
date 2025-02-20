import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pokedex_app/core/utils/theme_app.dart';
import 'package:pokedex_app/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:pokedex_app/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokedex_app/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_app/features/pokemon/domain/use_cases/pokemon_use_cases.dart';
import 'package:pokedex_app/features/pokemon/presentation/bindigns/pokemon_binding.dart';
import 'package:pokedex_app/features/pokemon/presentation/controllers/theme_controller.dart';
import 'package:pokedex_app/features/pokemon/presentation/pages/pokemon_list_page.dart';

final hivePokemonLocalDataSourceImpl = HivePokemonLocalDataSourceImpl();
final pokemonRemoteDataSourceImpl = PokemonRemoteDataSourceImpl();
final pokemonRepositoryImpl = PokemonRepositoryImpl(pokemonLocalDataSource: hivePokemonLocalDataSourceImpl, pokemonRemoteDataSource: pokemonRemoteDataSourceImpl);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();  

  await GetStorage.init();
  Get.put(ThemeController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  Get.put(PokemonUseCases(repository: pokemonRepositoryImpl));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeController.to.themeMode,
      defaultTransition: Transition.rightToLeft,
      initialBinding: PokemonBinding(),
      home: PokemonListPage(),
    );
  }
}

