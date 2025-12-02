/*
lib/screens/game_screen.dart (Teoria: Cap 1 - Integrazione Flutter/Flame)
Obiettivo: Mostrare il gioco.

Widget:

Usa GameWidget(game: MemoryGame(...)).

Usa la proprietà overlayBuilderMap per mostrare un pulsante "Pausa" o lo Score in alto, fatto con widget Flutter standard sopra al gioco Flame.
 */

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../game/memory_game.dart';
import '../controllers/game_controller.dart';
import '../widgets/responsive_scaffold.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recuperiamo il Controller per accedere al livello corrente
    final GameController controller = Get.find<GameController>();

    // Safety Check: Se l'utente arriva qui senza selezionare un livello, lo rimandiamo indietro
    if (controller.currentLevel == null) {
      Future.microtask(() => Get.offNamed('/levels'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return ResponsiveScaffold(
      title: "Level ${controller.currentLevel!.id}",
      child: Stack(
        children: [
          // 1. IL GIOCO FLAME
          // ClipRect impedisce che il gioco sbordi se ridimensioniamo strano
          ClipRect(
            child: GameWidget(
              game: MemoryGame(controller.currentLevel!),
            ),
          ),

          // 2. HUD (Heads-Up Display) - Punteggio e Info
          // Usiamo Flutter standard posizionato sopra il gioco
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Obx(() => Text(
                  "Score: ${controller.score.value}", // Reattivo!
                  style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                  ),
                )),
                Obx(() => Text(
                  "Time: ${controller.timeRemaining.value.toInt()}s",
                  style: TextStyle(
                  color: controller.timeRemaining.value < 10 ? Colors.redAccent : Colors.white, // Diventa rosso se manca poco!
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