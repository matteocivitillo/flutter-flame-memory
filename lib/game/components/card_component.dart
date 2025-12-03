import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart'; 
import 'package:flame/events.dart';
import '../../utils/app_assets.dart';
import '../memory_game.dart';

enum CardState { back, front }

class CardComponent extends SpriteGroupComponent<CardState>
    with HasGameRef<MemoryGame>, TapCallbacks {
  
  final int id;
  final int rank;
  final int suit;
  
  bool isMatched = false;
  
  Vector2 velocity = Vector2.zero();
  
  Vector2 gameSize = Vector2.zero();

  CardComponent({
    required this.id,
    required this.rank,
    required this.suit,
    required Vector2 position,
  }) : super(
          position: position,
          anchor: Anchor.center, 
        );

  @override
  Future<void> onLoad() async {
    String backPath = AppAssets.cardBack.replaceFirst('assets/images/', '');
    String frontPath = AppAssets.getCardImage(rank, suit).replaceFirst('assets/images/', '');

    final backSprite = await gameRef.loadSprite(backPath);
    final frontSprite = await gameRef.loadSprite(frontPath);

    sprites = {
      CardState.back: backSprite,
      CardState.front: frontSprite,
    };
    current = CardState.back;

    _randomizeVelocity();
  }

  void _randomizeVelocity() {
    final random = Random();
    double vx = (random.nextDouble() * 300) - 150; 
    double vy = (random.nextDouble() * 300) - 150;
    
    if (vx.abs() < 50) vx = 50 * (vx.isNegative ? -1 : 1);
    if (vy.abs() < 50) vy = 50 * (vy.isNegative ? -1 : 1);

    velocity = Vector2(vx, vy);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (current == CardState.front || isMatched) return;

    position += velocity * dt;

    if (gameSize.x == 0 || gameSize.y == 0) return;

    double halfW = size.x / 2;
    double halfH = size.y / 2;
    double topMargin = 100.0; 

    if (position.x <= halfW) {
      position.x = halfW;
      velocity.x = velocity.x.abs();
    } 
    else if (position.x >= gameSize.x - halfW) {
      position.x = gameSize.x - halfW;
      velocity.x = -velocity.x.abs(); 
    }

    if (position.y <= halfH + topMargin) {
      position.y = halfH + topMargin;
      velocity.y = velocity.y.abs(); 
    } 
    else if (position.y >= gameSize.y - halfH) {
      position.y = gameSize.y - halfH;
      velocity.y = -velocity.y.abs(); 
    }
  }

  void updateBounds(Vector2 newGameSize, double scaleFactor) {
    gameSize = newGameSize;
    
    size = Vector2(75, 105) * scaleFactor;
    
    double halfW = size.x / 2;
    double halfH = size.y / 2;

    double minX = halfW;
    double maxX = gameSize.x - halfW;
    if (maxX < minX) maxX = minX;

    double topMargin = 100.0;
    double minY = halfH + topMargin; 
    double maxY = gameSize.y - halfH;
    if (maxY < minY) maxY = minY;

    position.x = position.x.clamp(minX, maxX);
    position.y = position.y.clamp(minY, maxY);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (current == CardState.front || isMatched) return;
    gameRef.onCardTap(this);
  }

  void flip() {
    if (current == CardState.back) {
      current = CardState.front;
    } else {
      current = CardState.back;
      _randomizeVelocity(); 
    }
  }

  void match() {
    isMatched = true;
    add(
      ScaleEffect.to(
        Vector2.zero(), 
        EffectController(duration: 0.5), 
        onComplete: () {
          removeFromParent();
        },
      ),
    );
  }
}