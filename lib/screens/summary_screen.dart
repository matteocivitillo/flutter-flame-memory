import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/responsive_scaffold.dart';
import '../controllers/game_controller.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find<GameController>();
    final results = controller.getFinalResults();
    final sortedKeys = results.keys.toList()..sort();

    return ResponsiveScaffold(
      title: "Adventure Complete",
      showAppBar: false,
      
      // 1. LayoutBuilder ci dà le dimensioni dello schermo disponibile
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            // 2. ConstrainedBox forza la colonna ad essere ALMENO alta quanto lo schermo
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              
              // 3. IntrinsicHeight aiuta a calcolare gli spazi corretti
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    // 4. spaceBetween distribuisce i widget: Testa in alto, Tabella al centro, Bottone in basso
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      // --- BLOCCO 1: HEADER (Titolo) ---
                      Column(
                        children: [
                          const SizedBox(height: 20), // Margine superiore
                          const Icon(Icons.workspace_premium, size: 70, color: Colors.amber),
                          const SizedBox(height: 15),
                          Text(
                            "CONGRATULATIONS!",
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          const Text("You have completed all levels."),
                        ],
                      ),

                      // --- BLOCCO 2: TABELLA (Al Centro) ---
                      // Non serve Expanded qui grazie a spaceBetween, starà equidistante
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                children: [
                                  // Intestazione
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Level', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text('Time Taken', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  const Divider(height: 1),
                                  // Righe
                                  ...sortedKeys.map((id) {
                                    double time = results[id] ?? 0.0;
                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Level $id', style: const TextStyle(fontSize: 16)),
                                          Text('${time.toStringAsFixed(2)} sec', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // --- BLOCCO 3: FOOTER (Bottone) ---
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          width: 250,
                          height: 55, // Un po' più grande per importanza
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Restart Game?",
                                middleText: "This will delete all progress.",
                                textConfirm: "Yes",
                                textCancel: "No",
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  controller.resetGameData();
                                  Get.back();
                                  Get.offAllNamed('/');
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              elevation: 5,
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text("PLAY AGAIN (RESET)"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}