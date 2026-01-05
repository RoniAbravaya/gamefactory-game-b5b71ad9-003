import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:testLast-puzzle-03/game_objects/obstacle.dart';
import 'package:testLast-puzzle-03/game_objects/collectable.dart';

/// The Player component for the puzzle game.
class Player extends SpriteAnimationComponent with CollisionCallbacks {
  /// The player's current health.
  int _health = 100;

  /// The duration of invulnerability frames after taking damage.
  static const double _invulnerabilityDuration = 1.0;

  /// The timer for invulnerability frames.
  double _invulnerabilityTimer = 0.0;

  /// Whether the player is currently invulnerable.
  bool get isInvulnerable => _invulnerabilityTimer > 0.0;

  /// Constructs a new Player instance.
  Player(Vector2 position, Vector2 size)
      : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load player sprite animation
    animation = await loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2.all(32.0),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update invulnerability timer
    if (_invulnerabilityTimer > 0.0) {
      _invulnerabilityTimer -= dt;
    }
  }

  /// Handles player movement.
  void move(Vector2 direction) {
    position += direction * 200 * dt;
  }

  /// Handles player collision with obstacles.
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Obstacle) {
      // Handle collision with obstacle
      takeDamage(10);
    }
  }

  /// Handles player collision with collectables.
  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Collectable) {
      // Handle collision with collectable
      other.collect();
    }
  }

  /// Reduces the player's health by the specified amount.
  void takeDamage(int amount) {
    if (!isInvulnerable) {
      _health = (_health - amount).clamp(0, 100);
      _invulnerabilityTimer = _invulnerabilityDuration;
      // Handle player death or other consequences
    }
  }
}