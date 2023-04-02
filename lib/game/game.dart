import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:runner_flame_game/core/assets.dart';
import 'package:runner_flame_game/game/dino.dart';
import 'package:runner_flame_game/game/enemy.dart';
import 'package:runner_flame_game/game/enemy_manager.dart';

class DinoGame extends FlameGame with TapDetector {
  late Dino _dino;
  late ParallaxComponent _parallaxComponent;

  final _scoreText = TextComponent();
  int score = 0;

  late EnemyManager _enemyManager;

  @override
  Future<void> onLoad() async {
    _dino = Dino();
    _parallaxComponent = await _createParallax();
    _scoreText.text = score.toString();
    _enemyManager = EnemyManager();

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

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    _dino.jump();
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _scoreText.position = Vector2((canvasSize.x / 2) - (_scoreText.width / 2), 10);
  }

  @override
  void update(double dt) {
    super.update(dt);
    score += (60 * dt).toInt();
    _scoreText.text = score.toString();

    // TODO adicionar colisão pelo mixin
    children.whereType<Enemy>().forEach((enemy) {
      if(_dino.distance(enemy) < 20) {
        _dino.hit();
      }
    });
  }
}
