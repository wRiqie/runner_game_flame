import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:runner_flame_game/game/enemy.dart';
import 'package:runner_flame_game/game/game.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  late Random _random;
  late Timer _timer;
  int _spawnLevel = 0;

  @override
  void onLoad() {
    _random = Random();
    _timer = Timer(4, repeat: true, onTick: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final enemyType = EnemyType.values.elementAt(randomNumber);
    final newEnemy = Enemy(enemyType);
    gameRef.add(newEnemy);
  }

  void reset() {
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, onTick: () {
      spawnRandomEnemy();
    });
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas canvas) {}

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);

    var newSpawnLevel = gameRef.score ~/ 500;

    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;

      var newWaitTime = (4 / (1 + (0.1 * newSpawnLevel)));

      _timer.stop();
      _timer = Timer(newWaitTime, repeat: true, onTick: () {
        spawnRandomEnemy();
      });
      _timer.start();
    }
  }
}
