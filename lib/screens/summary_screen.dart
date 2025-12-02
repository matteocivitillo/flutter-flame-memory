import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/responsive_scaffold.dart';
import '../controllers/game_controller.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find<GameController>();
    
    // Recuperiamo i dati dal database tramite il controller
    final results = controller.getFinalResults();
    
    // Ordiniamo i risultati per ID livello (per sicurezza)
    final sortedKeys = results.keys.toList()..sort();

    return ResponsiveScaffold(
      title: "Adventure Complete",
      showAppBar: false,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.workspace_premium, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            
            Text(
              "CONGRATULATIONS!",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const Text("You have completed all levels."),
            
            const SizedBox(height: 40),

            // --- TABELLA RIASSUNTIVA ---
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Level', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Time Taken', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: sortedKeys.map((id) {
                    double time = results[id] ?? 0.0;
                    return DataRow(cells: [
                      DataCell(Text('Level $id')),
                      DataCell(Text('${time.toStringAsFixed(2)} sec')),
                    ]);
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 50),

            // --- TASTO RESTART (Distruttivo) ---
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Mostriamo un dialog di conferma per sicurezza
                  Get.defaultDialog(
                    title: "Restart Game?",
                    middleText: "This will delete all your progress and locked levels.",
                    textConfirm: "Yes, Restart",
                    textCancel: "Cancel",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      // 1. Cancella i dati
                      controller.resetGameData();
                      
                      // 2. Chiudi il dialog
                      Get.back();
                      
                      // 3. Torna alla schermata iniziale (rimuovendo tutto lo stack)
                      Get.offAllNamed('/');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.refresh),
                label: const Text("PLAY AGAIN (RESET)"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}