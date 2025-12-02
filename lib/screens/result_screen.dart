import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/responsive_scaffold.dart';
import '../controllers/game_controller.dart';
import '../models/level_model.dart'; // To check if next level exists

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Retrieve the Controller to read score and current level info
    final GameController controller = Get.find<GameController>();
    
    // Check if there is a next level available in the global list
    // We check if the current ID is less than the total number of levels
    bool hasNextLevel = controller.currentLevel != null && 
                        controller.currentLevel!.id < gameLevels.length;

    return ResponsiveScaffold(
      title: "Level Complete!",
      showAppBar: false, // Cleaner look
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // --- Icon / Image ---
          const Icon(Icons.emoji_events_rounded, size: 100, color: Colors.amber),
          
          const SizedBox(height: 20),
          
          // --- Title ---
          Text(
            "VICTORY!",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 10),

          // --- Score Display ---
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

          // --- Action Buttons ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Home Button
              ElevatedButton.icon(
                onPressed: () {
                  Get.offAllNamed('/levels'); // Reset navigation stack
                },
                icon: const Icon(Icons.grid_view_rounded),
                label: const Text("Levels"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),

              const SizedBox(width: 20),

              // 2. Next Level Button (Visible only if there is a next level)
              if (hasNextLevel)
                FilledButton.icon(
                  onPressed: () {
                    // Logic to start next level
                    int nextId = controller.currentLevel!.id + 1;
                    // Find the level object in the list
                    LevelModel nextLevel = gameLevels.firstWhere((l) => l.id == nextId);
                    
                    // Start game & Navigate
                    controller.startGame(nextLevel);
                    Get.offNamed('/game'); // Replace result screen with game
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