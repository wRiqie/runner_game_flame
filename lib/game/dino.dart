import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:runner_flame_game/core/assets.dart';

import '../core/constants.dart';

class Dino extends SpriteAnimationComponent {
  late SpriteAnimation _runAnimation;
  late SpriteAnimation _hitAnimation;
  late Timer _timer;

  double speedY = 0.0;
  double yMax = 0.0;

  Dino() {
    // 0 - 3
    // 4 - 10
    // 11 - 13
    // 14 - 16
    // 17 - 23

    Images().load(Assets.dinoSprite).then((value) {
      final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: value,
        columns: 24,
        rows: 1,
      );

      _runAnimation =
          spriteSheet.createAnimation(row: 0, from: 4, to: 10, stepTime: 0.1);

      _hitAnimation =
          spriteSheet.createAnimation(row: 0, from: 14, to: 16, stepTime: 0.1);

      animation = _runAnimation;

      _timer = Timer(1.2, onTick: () {
        run();
      });

      anchor = Anchor.center;
    });
  }

  void run() {
    animation = _runAnimation;
    _timer.stop();
  }

  void hit() {
    animation = _hitAnimation;
    _timer.start();
  }

  void jump() {
    if(isOnGround) {
      speedY = -600;
    }
  }

  bool get isOnGround => y >= yMax;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    width = height = size.x / numberOfTilesAlongWidth;
    x = width * 2;
    y = size.y - groundHeight - (height / 2) + dinoSpriteEmptySpace;

    yMax = y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    speedY += gravity * dt;

    y += speedY * dt;

    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
    }

    _timer.update(dt);
  }
}
