import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:runner_flame_game/core/assets.dart';
import 'package:runner_flame_game/core/constants.dart';
import 'package:runner_flame_game/game/dino.dart';
import 'package:runner_flame_game/game/enemy.dart';
import 'package:runner_flame_game/game/enemy_manager.dart';

class DinoGame extends FlameGame with TapDetector {
  late Dino _dino;
  late ParallaxComponent _parallaxComponent;

  late TextComponent _scoreText;
  int score = 0;

  late EnemyManager _enemyManager;

  ValueNotifier<int> get playerLife => _dino.life;

  DinoGame() {
    var style = const TextStyle(
      fontFamily: 'Audiowide',
      fontSize: 22,
      color: Colors.white,
    );
    var paint = TextPaint(style: style);
    _scoreText = TextComponent(textRenderer: paint);
  }

  @override
  Future<void> onLoad() async {
    _dino = Dino();
    _parallaxComponent = await _createParallax();
    _scoreText.text = score.toString();
    _enemyManager = EnemyManager();

    overlays.add(Constants.hud);

    add(_parallaxComponent);
    add(_dino);
    add(_scoreText);
    add(_enemyManager);
  }

  Future<ParallaxComponent> _createParallax() async {
    final images = [
      loadParallaxImage(
        Assets.paralax1,
      ),
      loadParallaxImage(
        Assets.paralax2,
      ),
      loadParallaxImage(
        Assets.paralax3,
      ),
      loadParallaxImage(
        Assets.paralax4,
      ),
      loadParallaxImage(
        Assets.paralax5,
      ),
      loadParallaxImage(
        Assets.ground,
        fill: LayerFill.none,
      ),
    ];

    final layers = images.map((image) async => ParallaxLayer(
          await image,
          velocityMultiplier: Vector2(images.indexOf(image) * 0.8, 0),
        ));

    return ParallaxComponent(
      parallax: Parallax(
        await Future.wait(layers),
        baseVelocity: Vector2(50, 0),
      ),
    );
  }

  void pauseGame() {
    pauseEngine();
    overlays.add(Constants.resume);
  }

  void resumeGame() {
    overlays.remove(Constants.resume);
    resumeEngine();
  }

  void _gameOver() {
    pauseEngine();

    overlays.remove(Constants.hud);
    overlays.add(Constants.gameOver);
  }

  void reset() {
    score = 0;
    _dino.life.value = 3;
    _dino.run();
    _enemyManager.reset();

    children.whereType<Enemy>().forEach((enemy) {
      remove(enemy);
    });
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    _dino.jump();
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _scoreText.position =
        Vector2((canvasSize.x / 2) - (_scoreText.width / 2), 10);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_dino.life.value <= 0) {
      _gameOver();
      return;
    }

    score += (60 * dt).toInt();
    _scoreText.text = score.toString();

    // TODO adicionar colisão pelo mixin
    children.whereType<Enemy>().forEach((enemy) {
      if (_dino.distance(enemy) < 20) {
        _dino.hit();
      }
    });
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    if (state != AppLifecycleState.resumed) pauseGame();
  }
}
