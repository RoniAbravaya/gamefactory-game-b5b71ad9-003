import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:testLast-puzzle-03/components/player.dart';
import 'package:testLast-puzzle-03/components/obstacle.dart';
import 'package:testLast-puzzle-03/components/collectible.dart';
import 'package:testLast-puzzle-03/services/analytics.dart';
import 'package:testLast-puzzle-03/services/ads.dart';
import 'package:testLast-puzzle-03/services/storage.dart';

/// The main game class for the 'testLast-puzzle-03' puzzle game.
class testLast-puzzle-03Game extends FlameGame with TapDetector {
  /// The current game state.
  GameState _gameState = GameState.playing;

  /// The player component.
  late Player _player;

  /// The list of obstacle components.
  final List<Obstacle> _obstacles = [];

  /// The list of collectible components.
  final List<Collectible> _collectibles = [];

  /// The current score.
  int _score = 0;

  /// The analytics service.
  final AnalyticsService _analyticsService = AnalyticsService();

  /// The ads service.
  final AdsService _adsService = AdsService();

  /// The storage service.
  final StorageService _storageService = StorageService();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the first level
    await _loadLevel(1);

    // Register for tap input
    camera.addInputs([this]);
  }

  /// Loads the specified level.
  Future<void> _loadLevel(int levelNumber) async {
    // Clear existing components
    _player = Player();
    _obstacles.clear();
    _collectibles.clear();

    // Load level data
    await _loadLevelData(levelNumber);

    // Add components to the game
    add(_player);
    _obstacles.forEach(add);
    _collectibles.forEach(add);

    // Reset the score
    _score = 0;

    // Set the game state to playing
    _gameState = GameState.playing;

    // Notify analytics
    _analyticsService.logLevelStart(levelNumber);
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Handle tap input
    if (_gameState == GameState.playing) {
      _player.jump();
    }
  }

  /// Updates the game state and handles game logic.
  @override
  void update(double dt) {
    super.update(dt);

    switch (_gameState) {
      case GameState.playing:
        // Update player and check for collisions
        _player.update(dt);
        _checkCollisions();

        // Check for level completion
        if (_isLevelComplete()) {
          _gameState = GameState.levelComplete;
          _analyticsService.logLevelComplete(_score);
          _storageService.saveHighScore(_score);
        }
        break;
      case GameState.levelComplete:
        // Show level complete UI and handle progression
        _showLevelCompleteUI();
        break;
      case GameState.gameOver:
        // Show game over UI and handle retry
        _showGameOverUI();
        break;
      case GameState.paused:
        // Handle paused state
        break;
    }
  }

  /// Checks for collisions between the player, obstacles, and collectibles.
  void _checkCollisions() {
    // Check for collisions with obstacles
    for (final obstacle in _obstacles) {
      if (_player.isColliding(obstacle)) {
        _gameState = GameState.gameOver;
        _analyticsService.logLevelFail();
        break;
      }
    }

    // Check for collisions with collectibles
    for (final collectible in _collectibles) {
      if (_player.isColliding(collectible)) {
        _collectibles.remove(collectible);
        _score += collectible.value;
        _analyticsService.logCollectiblePickup(collectible.value);
      }
    }
  }

  /// Checks if the current level is complete.
  bool _isLevelComplete() {
    // Check if all collectibles have been collected
    return _collectibles.isEmpty;
  }

  /// Loads the level data for the specified level number.
  Future<void> _loadLevelData(int levelNumber) async {
    // Load level data from storage or other source
    // and create the player, obstacles, and collectibles
  }

  /// Shows the level complete UI and handles progression.
  void _showLevelCompleteUI() {
    // Show the level complete UI
    // Handle level progression (unlock next level, show ads, etc.)
    _adsService.showRewardedAd();
  }

  /// Shows the game over UI and handles retries.
  void _showGameOverUI() {
    // Show the game over UI
    // Handle retries (reset level, show ads, etc.)
    _adsService.showRewardedAd();
  }
}

/// The possible game states.
enum GameState {
  playing,
  paused,
  gameOver,
  levelComplete,
}