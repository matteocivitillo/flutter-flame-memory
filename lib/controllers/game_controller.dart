/*
lib/controllers/game_controller.dart (Teoria: Cap 2 - GetX State Management)
Obiettivo: Fare da ponte tra Flame (il gioco) e Flutter (la UI).

Classe: GameController extends GetxController.

Proprietà:

RxInt score: Punteggio attuale.

RxBool isLevelCompleted: Per navigare alla schermata risultati.

Dipendenze: Usa Get.find<StorageService>() per salvare quando vinci.

Logica: Qui gestisci la logica di "vittoria" (tutte le carte trovate).
 */