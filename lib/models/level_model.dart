class LevelModel {
  final int id;
  final int cardCount; // Total number of floating cards
  final double timeLimit;

  const LevelModel({
    required this.id,
    required this.cardCount,
    required this.timeLimit,
  });
}

// Global configuration for the levels
final List<LevelModel> gameLevels = [
  const LevelModel(id: 1, cardCount: 4, timeLimit: 30),  // 2 Pairs
  const LevelModel(id: 2, cardCount: 6, timeLimit: 45),  // 3 Pairs
  const LevelModel(id: 3, cardCount: 8, timeLimit: 60),  // 4 Pairs
  const LevelModel(id: 4, cardCount: 10, timeLimit: 90), // 5 Pairs
];