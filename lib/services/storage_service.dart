import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService extends GetxService {
  late Box box;

  static const String _unlockedLevelsKey = 'unlocked_levels';
  static const String _levelTimesKey = 'level_times'; 

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


  Future<void> saveLevelResult(int levelId, double timeTaken) async {
    Map<dynamic, dynamic> results = box.get(_levelTimesKey, defaultValue: {});
    
    if (!results.containsKey(levelId) || timeTaken < results[levelId]) {
      results[levelId] = timeTaken;
      await box.put(_levelTimesKey, results);
      print("Tempo salvato per livello $levelId: ${timeTaken.toStringAsFixed(2)}s");
    }
  }

  Map<int, double> getAllResults() {
    Map<dynamic, dynamic> raw = box.get(_levelTimesKey, defaultValue: {});
    return raw.map((key, value) => MapEntry(key as int, value as double));
  }
  
  Future<void> resetProgress() async {
    await box.delete(_unlockedLevelsKey);
    await box.delete(_levelTimesKey);    
    
    await box.put(_unlockedLevelsKey, [1]);
    print("PROGRESSI CANCELLATI!");
  }
}