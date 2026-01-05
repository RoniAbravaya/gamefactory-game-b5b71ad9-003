import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

/// The player character in the puzzle game.
class Player extends SpriteAnimationComponent with HasGameRef, Collidable {
  /// The player's current health or lives.
  int _health = 3;

  /// The player's current score.
  int _score = 0;

  /// Initializes the player component.
  Player({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the player's sprite animation
    animation = await gameRef.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2.all(32),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update player movement and physics based on input
    handleInput(dt);
  }

  /// Handles player input and updates the player's movement and state.
  void handleInput(double dt) {
    // Implement player movement and jump logic based on input
    if (gameRef.keyboard.isPressed(LogicalKeyboardKey.space)) {
      // Jump
      velocity.y = -300;
    }

    // Apply gravity
    velocity.y += 1000 * dt;

    // Update player position
    position.add(velocity * dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    // Handle player collisions
    if (other is Obstacle) {
      // Reduce player health or handle collision with an obstacle
      _health--;
    }
  }

  /// Increases the player's score by the given amount.
  void increaseScore(int amount) {
    _score += amount;
  }

  /// Returns the player's current health or lives.
  int get health => _health;

  /// Returns the player's current score.
  int get score => _score;
}