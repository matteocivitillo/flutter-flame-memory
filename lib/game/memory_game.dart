import 'dart:async';
import 'dart:math';
import 'package:flame/camera.dart';
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

  CardComponent? firstCardFlipped;
  bool isProcessing = false;

  MemoryGame(this.level);

  @override
  Color backgroundColor() => const Color(0xFF2C3E50);

  @override
  Future<void> onLoad() async {
    // 1. Setup Camera (Top-Left Origin)
    camera = CameraComponent();
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewfinder.position = Vector2.zero(); // Force 0,0

    // 2. Spawn Cards
    await _spawnCards();
    
    // 3. Initial Layout Update
    _updateCardsLayout(size);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // Ensure camera stays anchored correctly
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewfinder.position = Vector2.zero();
    
    _updateCardsLayout(size);
  }

  Future<void> _spawnCards() async {
    int pairs = level.cardCount ~/ 2;
    List<CardComponent> deck = [];

    // 1. Creiamo le carte
    for (int i = 0; i < pairs; i++) {
      int rank = (i % 13) + 1; 
      int suit = i % 4;
      // Posizione provvisoria zero, la settiamo tra poco
      deck.add(CardComponent(id: i * 2, rank: rank, suit: suit, position: Vector2.zero()));
      deck.add(CardComponent(id: i * 2 + 1, rank: rank, suit: suit, position: Vector2.zero()));
    }

    // 2. Calcoliamo l'area di spawn sicura
    Random rnd = Random();
    
    // Dimensioni schermo attuali
    double w = size.x;
    double h = size.y;

    // Se per qualche motivo size è 0 (caricamento veloce), usiamo valori di fallback
    if (w <= 0) w = 800;
    if (h <= 0) h = 600;

    // Margini
    double margin = 50.0; // Bordo laterale
    double topSafeZone = 180.0; // Spazio abbondante in alto per Score e Titolo
    
    // Spazio effettivo dove possono nascere le carte
    double spawnWidth = w - (margin * 2);
    double spawnHeight = h - topSafeZone - margin;

    // 3. Assegniamo posizioni casuali
    for (var card in deck) {
      // Generiamo coordinate random dentro l'area sicura
      double randomX = margin + (rnd.nextDouble() * spawnWidth);
      double randomY = topSafeZone + (rnd.nextDouble() * spawnHeight);
      
      card.position = Vector2(randomX, randomY);
      world.add(card);
    }
  }

  void _updateCardsLayout(Vector2 screenSize) {
    // Determine scale factor based on screen width
    // Target width: approx 20-25% of screen width per card
    double targetW = screenSize.x * 0.25; 
    double baseW = 75.0; 
    
    double scaleFactor = (targetW / baseW).clamp(0.8, 2.5); 

    // Update all cards in the world
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