/*
lib/services/storage_service.dart (Teoria: Cap 4 - Dati Persistenti)
Obiettivo: Salvare quali livelli sono stati completati.

Classe: StorageService extends GetxService.

Metodi:

Future<StorageService> init(): Inizializza Hive e apre il box.

List<int> getUnlockedLevels(): Ritorna gli ID dei livelli sbloccati.

void unlockLevel(int levelId): Salva il nuovo livello sbloccato nel box.

*/

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService extends GetxService {
  late Box box;

  static const String _unloackedLevelsKey = 'unlocked_levels';

  Future<StorageService> init () async  {
    await Hive.initFlutter();

    box = await Hive.openBox('storage');

    if (box.get(_unloackedLevelsKey) == null ) {
      await box.put(_unloackedLevelsKey, [1]);
    }
    return this;
  }

  List<int> getUnlockedLevels() {
    final levels = box.get(_unloackedLevelsKey, defaultValue: [1]);
    return List<int>.from(levels);
  }

  Future<void> unlockLevel(int levelId) async {
    List<int> currentLevels = getUnlockedLevels();
    if (!currentLevels.contains(levelId)) {
      currentLevels.add(levelId);
      await box.put(_unloackedLevelsKey, currentLevels);
    }
  }

  Future<void> resetProgress() async {
    await box.put(_unloackedLevelsKey, [1]);
  }
}