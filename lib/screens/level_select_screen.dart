import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/responsive_scaffold.dart';
import '../models/level_model.dart';
import '../controllers/game_controller.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find<GameController>();

    return ResponsiveScaffold(
      title: "Select Level",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int columns = constraints.maxWidth > 600 ? 3 : 1;
          
          // WRAPPER OBX: Ascolta i cambiamenti nel controller
          return Obx(() {
            // Prendiamo la lista aggiornata dal controller
            final unlockedList = controller.unlockedLevels.toList();

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio: 2.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: gameLevels.length,
              itemBuilder: (context, index) {
                final level = gameLevels[index];
                final isUnlocked = unlockedList.contains(level.id);

                return _LevelCard(
                  level: level,
                  isUnlocked: isUnlocked,
                  onTap: () {
                    if (isUnlocked) {
                      controller.startGame(level);
                      Get.toNamed('/game'); 
                    } else {
                      Get.snackbar(
                        "Level Locked", 
                        "Complete previous levels!",
                        backgroundColor: Colors.redAccent.withOpacity(0.8),
                        colorText: Colors.white,
                      );
                    }
                  },
                );
              },
            );
          });
        },
      ),
    );
  }
}
// ... _LevelCard rimane uguale ...
// --- Helper Widget for the Card ---
class _LevelCard extends StatelessWidget {
  final LevelModel level;
  final bool isUnlocked;
  final VoidCallback onTap;

  const _LevelCard({
    required this.level,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Visual style depends on state (Locked vs Unlocked)
    final color = isUnlocked 
        ? Theme.of(context).colorScheme.primaryContainer 
        : Colors.grey[300];
    
    final textColor = isUnlocked 
        ? Theme.of(context).colorScheme.onPrimaryContainer 
        : Colors.grey[600];

    return Card(
      color: color,
      elevation: isUnlocked ? 4 : 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Level Info
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level ${level.id}",
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    "${level.cardCount} Floating Cards",
                    style: TextStyle(color: textColor?.withOpacity(0.8)),
                  ),
                ],
              ),
              
              // Status Icon (Lock or Play)
              Icon(
                isUnlocked ? Icons.play_circle_fill : Icons.lock,
                size: 32,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}