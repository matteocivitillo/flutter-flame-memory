class AppAssets {
  // Percorso base dove stanno le immagini
  static const String _basePath = 'assets/images';

  // Immagine del dorso (assicurati di avere un file chiamato card_back.png o cambia nome qui)
  static const String cardBack = '$_basePath/back_red.png';
  
  // --- ECCO IL METODO CHE CERCAVI ---
  static String getCardImage(int rank, int suit) {
    // 1. Traduciamo il numero del seme in testo
    String suitName = '';
    switch (suit) {
      case 0: suitName = 'clubs'; break;    // Fiori
      case 1: suitName = 'diamonds'; break; // Quadri
      case 2: suitName = 'hearts'; break;   // Cuori
      case 3: suitName = 'spades'; break;   // Picche
      default: suitName = 'clubs';
    }

    // 2. Traduciamo il numero del valore in testo
    String rankName = '';
    switch (rank) {
      case 1: rankName = 'ace'; break;      // Asso
      case 11: rankName = 'jack'; break;    // Fante
      case 12: rankName = 'queen'; break;   // Regina
      case 13: rankName = 'king'; break;    // Re
      default: rankName = rank.toString();  // 2, 3, 4... diventano stringhe "2", "3"
    }

    // 3. Uniamo tutto per formare il nome del file reale
    // Es: assets/images/ace_of_spades.png
    return '$_basePath/${rankName}_of_${suitName}.png';
  }
}