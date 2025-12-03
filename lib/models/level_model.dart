class LevelModel {
  final int id;
  final int cardCount; 
  final double timeLimit;

  const LevelModel({
    required this.id,
    required this.cardCount,
    required this.timeLimit,
  });
}

final List<LevelModel> gameLevels = [
  const LevelModel(id: 1, cardCount: 4, timeLimit: 30),  
  const LevelModel(id: 2, cardCount: 6, timeLimit: 45),  
  const LevelModel(id: 3, cardCount: 8, timeLimit: 60),  
  const LevelModel(id: 4, cardCount: 10, timeLimit: 90), 
];