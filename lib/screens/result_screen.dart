import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/responsive_scaffold.dart';
import '../controllers/game_controller.dart';
import '../models/level_model.dart'; 

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find<GameController>();
    
    bool hasNextLevel = controller.currentLevel != null && 
                        controller.currentLevel!.id < gameLevels.length;

    return ResponsiveScaffold(
      title: "Level Complete!",
      showAppBar: false, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events_rounded, size: 100, color: Colors.amber),
          
          const SizedBox(height: 20),
          
          Text(
            "VICTORY!",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Final Score",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "${controller.score.value}",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Get.offAllNamed('/levels'); 
                },
                icon: const Icon(Icons.grid_view_rounded),
                label: const Text("Levels"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),

              const SizedBox(width: 20),

              if (hasNextLevel)
                FilledButton.icon(
                  onPressed: () {
                    int nextId = controller.currentLevel!.id + 1;
                    LevelModel nextLevel = gameLevels.firstWhere((l) => l.id == nextId);
                    
                    controller.startGame(nextLevel);
                    Get.offNamed('/game'); 
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Next Level"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}