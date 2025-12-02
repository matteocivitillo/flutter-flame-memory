import 'dart:async'; // <--- NECESSARIO PER IL TIMER
import 'package:get/get.dart';
import '../models/level_model.dart';
import '../services/storage_service.dart';

class GameController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  var score = 0.obs;
  var timeRemaining = 0.0.obs;
  var matchesFound = 0.obs;
  var isGameOver = false.obs;
  var isLevelCompleted = false.obs;
  
  var unlockedLevels = <int>[].obs;

  LevelModel? currentLevel;
  Timer? _gameTimer; // <--- Riferimento al timer per poterlo stoppare

  @override
  void onInit() {
    super.onInit();
    refreshUnlockedLevels();
  }
  
  // Importante: Se il controller viene distrutto, fermiamo il timer
  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }

  void refreshUnlockedLevels() {
    unlockedLevels.value = _storage.getUnlockedLevels();
  }
  
  List<int> getUnlockedLevels() {
    return _storage.getUnlockedLevels();
  }

  void startGame(LevelModel level) {
    currentLevel = level;
    score.value = 0;
    matchesFound.value = 0;
    isGameOver.value = false;
    isLevelCompleted.value = false;
    timeRemaining.value = level.timeLimit;
    
    // AVVIAMO IL TIMER
    _startTimer();
    
    print("Game Started: Level ${level.id}");
  }

  // --- LOGICA TIMER ---
  void _startTimer() {
    // Cancelliamo eventuali timer precedenti per sicurezza
    _stopTimer();
    
    // Timer che scatta ogni secondo
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isLevelCompleted.value || isGameOver.value) {
        timer.cancel();
        return;
      }

      if (timeRemaining.value > 0) {
        timeRemaining.value--; // Decrementa di 1 secondo
      } else {
        // TEMPO SCADUTO!
        _handleGameOver();
      }
    });
  }

  void _stopTimer() {
    if (_gameTimer != null && _gameTimer!.isActive) {
      _gameTimer!.cancel();
    }
  }

  void _handleGameOver() {
    _stopTimer();
    isGameOver.value = true;
    
    Get.snackbar(
      "Game Over", 
      "Time is up! Try again.",
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
    
    // Dopo un po' torniamo ai livelli
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/levels');
    });
  }

  void onPairMatched() {
    matchesFound.value++;
    score.value += 100;
    
    if (currentLevel != null && matchesFound.value == currentLevel!.cardCount / 2) {
      _completeLevel();
    }
  }

  void _completeLevel() {
    if (isGameOver.value) return; 
    
    // FERMIAMO IL TIMER SUBITO!
    _stopTimer();

    isLevelCompleted.value = true;
    
    if (currentLevel != null) {
      // Calcolo Tempo Impiegato
      // Ora timeRemaining sarà diverso da timeLimit!
      double timeTaken = currentLevel!.timeLimit - timeRemaining.value;
      
      _storage.saveLevelResult(currentLevel!.id, timeTaken);

      int nextLevelId = currentLevel!.id + 1;
      
      // Controllo se è l'ultimo livello
      bool isLastLevel = nextLevelId > gameLevels.length;

      if (!isLastLevel) {
        _storage.unlockLevel(nextLevelId);
        refreshUnlockedLevels();
        
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offNamed('/result'); 
        });
      } else {
        print("GIOCO FINITO!");
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offNamed('/summary'); 
        });
      }
    }
  }
  
  Map<int, double> getFinalResults() {
    return _storage.getAllResults();
  }
  
  void resetGameData() {
    _storage.resetProgress();
    refreshUnlockedLevels(); 
  }
}