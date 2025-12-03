class AppAssets {
  static const String _basePath = 'assets/images';

  static const String cardBack = '$_basePath/back_red.png';
  
  static String getCardImage(int rank, int suit) {
    String suitName = '';
    switch (suit) {
      case 0: suitName = 'clubs'; break;    
      case 1: suitName = 'diamonds'; break;
      case 2: suitName = 'hearts'; break;   
      case 3: suitName = 'spades'; break;   
      default: suitName = 'clubs';
    }

    String rankName = '';
    switch (rank) {
      case 1: rankName = 'ace'; break;      
      case 11: rankName = 'jack'; break;    
      case 12: rankName = 'queen'; break;  
      case 13: rankName = 'king'; break;    
      default: rankName = rank.toString(); 
    }

    return '$_basePath/${rankName}_of_${suitName}.png';
  }
}