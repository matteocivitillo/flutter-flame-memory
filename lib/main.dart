import 'package:ember_match/controllers/game_controller.dart';
import 'package:ember_match/screens/level_select_screen.dart';
import 'package:ember_match/screens/result_screen.dart';
import 'package:ember_match/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/storage_service.dart';
import 'screens/game_screen.dart';
import 'screens/summary_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await Get.putAsync(() => StorageService().init());

  Get.put(GameController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp( {super.key} );

  @override
  Widget build (BuildContext context){
    return GetMaterialApp(
      title: "Memory Game",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Arial"
      ),

      initialRoute: '/',

      getPages: [
        GetPage(name: '/', page: () => const StartScreen()),

        // USA LA VERA SCHERMATA:
        GetPage(name: '/levels', page: () => const LevelSelectScreen()),
        GetPage(name: '/game', page: () => const GameScreen()),
        GetPage(name: '/result', page: () => const ResultScreen()),
        GetPage(name: '/summary', page: () => const SummaryScreen()),
      ],
    );
  }
}
