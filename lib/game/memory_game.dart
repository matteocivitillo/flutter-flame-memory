/*
lib/game/memory_game.dart (Teoria: Cap 5 - Flame & Forge2D/Physics)
Nota: Anche se è un memory, usiamo Flame come richiesto. Non serve necessariamente la fisica gravitaria (Forge2D), ma serve la struttura di Flame.

Classe: MemoryGame extends FlameGame.

Metodo onLoad:

Usa camera = CameraComponent.withFixedResolution(width: 800, height: 600); (Requisito fondamentale del handout!).

Riceve il LevelModel dal costruttore.

Genera la griglia di carte calcolando le posizioni X e Y.

Gestione Carte: Aggiunge le carte al world.
*/