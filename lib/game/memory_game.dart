import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/level_model.dart';
import '../controllers/game_controller.dart';
import 'components/card_component.dart';

class MemoryGame extends FlameGame {
  final LevelModel level;
  final GameController controller = Get.find<GameController>();
  final Color topColor; 
  CardComponent? firstCardFlipped;
  bool isProcessing = false;

  MemoryGame(this.level, {required this.topColor});

  @override
  Future<void> onLoad() async {
    world.add(AnimatedBackgroundComponent(topColor: topColor, priority: -100));

    camera = CameraComponent();
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewfinder.position = Vector2.zero();

    await _spawnCards();
    _updateCardsLayout(size);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewfinder.position = Vector2.zero();
    _updateCardsLayout(size);
  }

  Future<void> _spawnCards() async {
    int pairs = level.cardCount ~/ 2;
    List<CardComponent> deck = [];

    for (int i = 0; i < pairs; i++) {
      int rank = (i % 13) + 1; 
      int suit = i % 4;
      deck.add(CardComponent(id: i * 2, rank: rank, suit: suit, position: Vector2.zero()));
      deck.add(CardComponent(id: i * 2 + 1, rank: rank, suit: suit, position: Vector2.zero()));
    }

    Random rnd = Random();
    double w = size.x > 0 ? size.x : 800;
    double h = size.y > 0 ? size.y : 600;

    double margin = 50.0;
    double topSafeZone = 180.0; 
    
    double spawnWidth = w - (margin * 2);
    double spawnHeight = h - topSafeZone - margin;

    for (var card in deck) {
      double randomX = margin + (rnd.nextDouble() * spawnWidth);
      double randomY = topSafeZone + (rnd.nextDouble() * spawnHeight);
      card.position = Vector2(randomX, randomY);
      world.add(card);
    }
  }

  void _updateCardsLayout(Vector2 screenSize) {
    double targetW = screenSize.x * 0.25; 
    double baseW = 75.0; 
    double scaleFactor = (targetW / baseW).clamp(0.8, 2.5); 

    for (var card in world.children.query<CardComponent>()) {
      card.updateBounds(screenSize, scaleFactor);
    }
  }

  void onCardTap(CardComponent card) {
    if (isProcessing) return; 
    card.flip();
    if (firstCardFlipped == null) {
      firstCardFlipped = card;
    } else {
      _checkMatch(firstCardFlipped!, card);
    }
  }

  void _checkMatch(CardComponent card1, CardComponent card2) async {
    isProcessing = true; 
    if (card1.rank == card2.rank && card1.suit == card2.suit) {
      card1.match();
      card2.match();
      controller.onPairMatched();
      firstCardFlipped = null;
      isProcessing = false;
    } else {
      await Future.delayed(const Duration(seconds: 1));
      card1.flip();
      card2.flip();
      firstCardFlipped = null;
      isProcessing = false;
    }
  }
}

class AnimatedBackgroundComponent extends PositionComponent with HasGameRef {
  final Color topColor;
  
  AnimatedBackgroundComponent({required this.topColor, super.priority});

  double _time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt * 0.3; 
    size = gameRef.size;
  }

  @override
  void render(Canvas canvas) {
    final colorTop = topColor;
    
    final colorBottom = Color.lerp(
      Colors.deepPurple.shade900, 
      Colors.black, 
      (sin(_time) + 1) / 2
    )!;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,    
        end: Alignment.bottomCenter,   
        stops: const [0.0, 1.0],      
        colors: [colorTop, colorBottom],
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
  }
}