import 'dart:async';
import 'package:flutter/material.dart';
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
  Timer? _gameTimer;

  @override
  void onInit() {
    super.onInit();
    refreshUnlockedLevels();
  }
  
  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }

  // Chiamato quando si esce dalla schermata di gioco con "Indietro"
  void stopGamePrematurely() {
    print("Gioco interrotto dall'utente.");
    _stopTimer();
    isGameOver.value = false;
    isLevelCompleted.value = false;
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
    
    _startTimer();
    print("Game Started: Level ${level.id}");
  }

  void _startTimer() {
    _stopTimer();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isLevelCompleted.value || isGameOver.value) {
        timer.cancel();
        return;
      }

      if (timeRemaining.value > 0) {
        timeRemaining.value--; 
      } else {
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
    
    Get.defaultDialog(
      title: "GAME OVER",
      titleStyle: const TextStyle(
        color: Colors.redAccent, 
        fontSize: 24, 
        fontWeight: FontWeight.bold
      ),
      middleText: "Time is up! Don't give up.",
      backgroundColor: Colors.white,
      barrierDismissible: false,
      radius: 15,
      contentPadding: const EdgeInsets.all(20),
      
      confirm: SizedBox(
        width: 140,
        child: ElevatedButton.icon(
          onPressed: () {
            Get.back(); 
            if (currentLevel != null) {
              startGame(currentLevel!); 
              Get.offNamed('/game');    
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, 
            foregroundColor: Colors.white
          ),
          icon: const Icon(Icons.refresh),
          label: const Text("Try Again"),
        ),
      ),
      
      cancel: SizedBox(
        width: 140,
        child: OutlinedButton.icon(
          onPressed: () {
            Get.back(); 
            Get.offNamed('/levels'); 
          },
          icon: const Icon(Icons.grid_view),
          label: const Text("Levels"),
        ),
      ),
    );
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
    _stopTimer();
    isLevelCompleted.value = true;
    
    if (currentLevel != null) {
      double timeTaken = currentLevel!.timeLimit - timeRemaining.value;
      _storage.saveLevelResult(currentLevel!.id, timeTaken);

      int nextLevelId = currentLevel!.id + 1;
      bool isLastLevel = nextLevelId > gameLevels.length;

      if (!isLastLevel) {
        _storage.unlockLevel(nextLevelId);
        refreshUnlockedLevels();
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offNamed('/result'); 
        });
      } else {
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