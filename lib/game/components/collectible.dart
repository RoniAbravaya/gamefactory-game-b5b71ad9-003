import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/// A collectible item component for a puzzle game.
///
/// This component represents a collectible item that the player can pick up.
/// It has collision detection, a score value, optional animation, and a sound
/// effect trigger on collection.
class Collectible extends SpriteComponent with CollisionCallbacks {
  /// The score value of the collectible.
  final int scoreValue;

  /// The audio player for the collection sound effect.
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Creates a new instance of the [Collectible] component.
  ///
  /// [sprite] is the sprite to be used for the collectible.
  /// [position] is the initial position of the collectible.
  /// [scoreValue] is the score value of the collectible.
  Collectible({
    required Sprite sprite,
    required Vector2 position,
    required this.scoreValue,
  }) : super(
          sprite: sprite,
          position: position,
          size: Vector2.all(32.0),
        ) {
    // Add optional animation effects, such as spinning or floating
    add(RotateEffect.by(
      2 * pi,
      EffectController(
        duration: 2.0,
        infinite: true,
      ),
    ));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // Check if the other component is the player
    if (other is Player) {
      // Trigger the collection sound effect
      _audioPlayer.play(AssetSource('collect_sound.mp3'));

      // Notify the game that the collectible has been collected
      other.collectItem(scoreValue);

      // Remove the collectible from the game
      removeFromParent();
    }
  }
}