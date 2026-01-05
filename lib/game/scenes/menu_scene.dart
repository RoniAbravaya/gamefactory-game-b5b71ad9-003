import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// The main menu scene for the puzzle game.
class MenuScene extends Component with HasGameRef {
  /// The title of the game.
  late final TextComponent _titleComponent;

  /// The play button.
  late final ButtonComponent _playButton;

  /// The level select button.
  late final ButtonComponent _levelSelectButton;

  /// The settings button.
  late final ButtonComponent _settingsButton;

  /// The background animation.
  late final SpriteComponent _backgroundAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Create the title component
    _titleComponent = TextComponent(
      text: 'testLast-puzzle-03',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.2),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(_titleComponent);

    // Create the play button
    _playButton = ButtonComponent(
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.4),
      size: Vector2(200, 60),
      anchor: Anchor.topCenter,
      child: TextComponent(
        text: 'Play',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        // Navigate to the game scene
        gameRef.navigateTo(GameScene());
      },
    );
    add(_playButton);

    // Create the level select button
    _levelSelectButton = ButtonComponent(
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.5),
      size: Vector2(200, 60),
      anchor: Anchor.topCenter,
      child: TextComponent(
        text: 'Level Select',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        // Navigate to the level select scene
        gameRef.navigateTo(LevelSelectScene());
      },
    );
    add(_levelSelectButton);

    // Create the settings button
    _settingsButton = ButtonComponent(
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.6),
      size: Vector2(200, 60),
      anchor: Anchor.topCenter,
      child: TextComponent(
        text: 'Settings',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        // Navigate to the settings scene
        gameRef.navigateTo(SettingsScene());
      },
    );
    add(_settingsButton);

    // Create the background animation
    _backgroundAnimation = SpriteComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      sprite: await gameRef.loadSprite('background.png'),
    );
    add(_backgroundAnimation);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the background animation
    _backgroundAnimation.angle += 0.01 * dt;
  }
}