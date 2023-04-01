import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:runner_flame_game/core/assets.dart';
import 'package:runner_flame_game/game/dino.dart';
import 'package:runner_flame_game/game/enemy.dart';

class DinoGame extends FlameGame with TapDetector {
  late Dino _dino;
  late ParallaxComponent _parallaxComponent;

  @override
  Future<void> onLoad() async {
    _dino = Dino();

    _parallaxComponent = await _createParallax();

    add(_parallaxComponent);
    add(_dino);

    var enemy = Enemy(EnemyType.angryPig);
    add(enemy);
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
}
