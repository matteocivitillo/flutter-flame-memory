import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../game/memory_game.dart';
import '../controllers/game_controller.dart';
import '../widgets/responsive_scaffold.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController controller = Get.find<GameController>();

  @override
  void dispose() {
    controller.stopGamePrematurely();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.currentLevel == null) {
      Future.microtask(() => Get.offNamed('/levels'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final Color appBarColor = Theme.of(context).colorScheme.inversePrimary;

    return ResponsiveScaffold(
      title: "Level ${controller.currentLevel!.id}",
      fullScreen: true,
      child: Stack(
        children: [
          GameWidget(
            game: MemoryGame(
              controller.currentLevel!, 
              topColor: appBarColor
            ),
          ),
          
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Text(
                    "Score: ${controller.score.value}",
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  Obx(() => Text(
                    "Time: ${controller.timeRemaining.value.toInt()}s",
                    style: TextStyle(
                      color: controller.timeRemaining.value < 10 ? Colors.redAccent : Colors.white,
                      fontSize: 16,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}