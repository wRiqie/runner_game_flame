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

  const EnemyData({
    required this.imageName,
    required this.srcSize,
    required this.columns,
    required this.rows,
  });
}

enum EnemyType {
  angryPig,
  bat,
  rino;
}

class Enemy extends SpriteAnimationComponent {
  double speed = 200;
  late Vector2 _size;

  double textureWidth = 0.0;
  double textureHeight = 0.0;

  final data = {
    EnemyType.angryPig: EnemyData(
      imageName: Assets.angryPig,
      srcSize: Vector2(36, 30),
      columns: 16,
      rows: 1,
    ),
    EnemyType.bat: EnemyData(
      imageName: Assets.bat,
      srcSize: Vector2(46, 30),
      columns: 7,
      rows: 1,
    ),
    EnemyType.rino: EnemyData(
      imageName: Assets.rino,
      srcSize: Vector2(52, 34),
      columns: 6,
      rows: 1,
    ),
  };

  final EnemyType enemyType;

  Enemy(this.enemyType);

  @override
  Future<void> onLoad() async {
    final enemyData = data[enemyType];

    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: await Images().load(enemyData!.imageName),
      columns: enemyData.columns,
      rows: enemyData.rows,
    )..srcSize.setFrom(enemyData.srcSize);

    animation =
        spriteSheet.createAnimation(row: 0, from: 0, to: enemyData.columns - 1, stepTime: 0.1);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    
    textureWidth = data[enemyType]!.srcSize.x;
    textureHeight = data[enemyType]!.srcSize.y;

    double scaleFactor = (size.x / numberOfTilesAlongWidth) / textureWidth;

    _size = size;
    width = textureWidth * scaleFactor;
    height = textureHeight * scaleFactor;
    x = size.x + width;
    y = size.y - groundHeight - height;
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= speed * dt;

    if (x < -width) {
      x = _size.x + width;
    }
  }
}
