import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:runner_flame_game/game/game.dart';
import 'package:runner_flame_game/widgets/game_over_widget.dart';
import 'package:runner_flame_game/widgets/hud_widget.dart';
import 'package:runner_flame_game/widgets/resume_widget.dart';

import 'core/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Audiowide'
      ),
      home: Scaffold(
        body: GameWidget(
          game: DinoGame(),
          overlayBuilderMap: {
            Constants.hud: (context, DinoGame game) => HudWidget(game: game),
            Constants.resume: (context, DinoGame game) => ResumeWidget(game: game),
            Constants.gameOver: (context, DinoGame game) => GameOverWidget(game: game),
          },
        ),
      ),
    ),
  );
}
