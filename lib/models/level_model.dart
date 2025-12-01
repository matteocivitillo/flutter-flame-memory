/*
lib/models/level_model.dart (Teoria: Cap 2 - Dati)
Obiettivo: Definire cos'è un livello.

Classe: LevelModel.

Proprietà:

final int id; (es. 1, 2, 3)

final int rows; (es. 2)

final int cols; (es. 3 -> totale 6 carte)

final double timeLimit; (tempo per finire il livello) 
 */

class LevelModel {
  final int id; 
  final int rows; 
  final int cols; 
  final double timeLimit;

  LevelModel({
    required this.id,
    required this.rows,
    required this.cols,
    required this.timeLimit,
  });

  int get totalCards => rows * cols;

  final List<LevelModel> predefinedLevels = [
    LevelModel(id: 1, rows: 3, cols: 4, timeLimit: 60.0),
    LevelModel(id: 2, rows: 4, cols: 4, timeLimit: 90.0),
    LevelModel(id: 3, rows: 5, cols: 5, timeLimit: 120.0),
    LevelModel(id: 4, rows: 6, cols: 6, timeLimit: 150.0),
  ];

}