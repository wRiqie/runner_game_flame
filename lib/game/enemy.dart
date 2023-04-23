import 'dart:math';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'package:runner_flame_game/core/assets.dart';

import '../core/constants.dart';

class EnemyData {
  final String imageName;
  final Vector2 srcSize;
  final int columns;
  final int rows;
  final bool canFly;
  final int speed;

  const EnemyData({
    required this.imageName,
    required this.srcSize,
    required this.columns,
    required this.rows,
    this.canFly = false,
    required this.speed,
  });
}

enum EnemyType {
  angryPig,
  bat,
  rino;
}

class Enemy extends SpriteAnimationComponent {
  late EnemyData enemyData;
  final _random = Random();

  final data = {
    EnemyType.angryPig: EnemyData(
      imageName: Assets.angryPig,
      srcSize: Vector2(36, 30),
      columns: 16,
      rows: 1,
      speed: 250,
    ),
    EnemyType.bat: EnemyData(
      imageName: Assets.bat,
      srcSize: Vector2(46, 30),
      columns: 7,
      rows: 1,
      canFly: true,
      speed: 300,
    ),
    EnemyType.rino: EnemyData(
      imageName: Assets.rino,
      srcSize: Vector2(52, 34),
      columns: 6,
      rows: 1,
      speed: 350,
    ),
  };

  final EnemyType enemyType;

  Enemy(this.enemyType) {
    enemyData = data[enemyType]!;
  }

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: await Images().load(enemyData.imageName),
      columns: enemyData.columns,
      rows: enemyData.rows,
    )..srcSize.setFrom(enemyData.srcSize);

    animation = spriteSheet.createAnimation(
        row: 0, from: 0, to: enemyData.columns - 1, stepTime: 0.1);

    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    double scaleFactor =
        (size.x / Constants.numberOfTilesAlongWidth) / enemyData.srcSize.x;

    width = enemyData.srcSize.x * scaleFactor;
    height = enemyData.srcSize.y * scaleFactor;
    x = size.x + width;
    y = size.y - Constants.groundHeight - (height / 2);

    if (enemyData.canFly && _random.nextBool()) {
      y -= height;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= enemyData.speed * dt;

    if (x < -width) {
      removeFromParent();
    }
  }
}
