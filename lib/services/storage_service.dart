import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService extends GetxService {
  late Box box;

  static const String _unlockedLevelsKey = 'unlocked_levels';
  static const String _levelTimesKey = 'level_times'; // Nuova chiave per i tempi

  Future<StorageService> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox('ember_match_storage');
    
    if (box.get(_unlockedLevelsKey) == null) {
      await box.put(_unlockedLevelsKey, [1]);
    }
    return this;
  }

  List<int> getUnlockedLevels() {
    final levels = box.get(_unlockedLevelsKey, defaultValue: [1]);
    return List<int>.from(levels);
  }

  Future<void> unlockLevel(int levelId) async {
    List<int> currentLevels = getUnlockedLevels();
    if (!currentLevels.contains(levelId)) {
      currentLevels.add(levelId);
      await box.put(_unlockedLevelsKey, currentLevels);
    }
  }

  // --- NUOVI METODI PER I TEMPI ---

  // Salva il tempo impiegato (in secondi) per un livello
  Future<void> saveLevelResult(int levelId, double timeTaken) async {
    // Recuperiamo la mappa esistente (o ne creiamo una vuota)
    // Usiamo Map<dynamic, dynamic> perché Hive restituisce quello
    Map<dynamic, dynamic> results = box.get(_levelTimesKey, defaultValue: {});
    
    // Aggiorniamo il tempo solo se è migliore (minore) o se non esiste
    if (!results.containsKey(levelId) || timeTaken < results[levelId]) {
      results[levelId] = timeTaken;
      await box.put(_levelTimesKey, results);
      print("Tempo salvato per livello $levelId: ${timeTaken.toStringAsFixed(2)}s");
    }
  }

  // Recupera tutti i risultati per la tabella finale
  Map<int, double> getAllResults() {
    Map<dynamic, dynamic> raw = box.get(_levelTimesKey, defaultValue: {});
    // Convertiamo in una mappa sicura <int, double>
    return raw.map((key, value) => MapEntry(key as int, value as double));
  }
  
  // RESET TOTALE (Modificato per cancellare tutto)
  Future<void> resetProgress() async {
    await box.delete(_unlockedLevelsKey); // Cancella livelli sbloccati
    await box.delete(_levelTimesKey);     // Cancella i tempi
    
    // Ripristina stato iniziale (Livello 1 sbloccato)
    await box.put(_unlockedLevelsKey, [1]);
    print("PROGRESSI CANCELLATI!");
  }
}