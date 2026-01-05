import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:testLast-puzzle-03/game_objects/player.dart';

/// Represents an obstacle in the puzzle game.
class Obstacle extends PositionComponent with CollisionCallbacks, HasHitboxes {
  final Sprite _sprite;
  final double _speed;
  final double _damage;

  /// Creates a new instance of the Obstacle.
  ///
  /// [position] is the initial position of the obstacle.
  /// [size] is the size of the obstacle.
  /// [sprite] is the sprite to be used for the visual representation.
  /// [speed] is the speed at which the obstacle moves.
  /// [damage] is the amount of damage the obstacle deals on collision.
  Obstacle({
    required Vector2 position,
    required Vector2 size,
    required Sprite sprite,
    required double speed,
    required double damage,
  })  : _sprite = sprite,
        _speed = speed,
        _damage = damage,
        super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addHitbox(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= _speed * dt;

    // Respawn the obstacle if it goes off-screen
    if (position.x < -size.x) {
      position.x = size.x + 100;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      other.takeDamage(_damage);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _sprite.render(canvas, position: position, size: size);
  }
}