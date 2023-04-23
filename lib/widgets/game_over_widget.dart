import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:runner_flame_game/core/constants.dart';
import 'package:runner_flame_game/game/game.dart';

class GameOverWidget extends StatefulWidget {
  final DinoGame game;
  const GameOverWidget({super.key, required this.game});

  @override
  State<GameOverWidget> createState() => _GameOverWidgetState();
}

class _GameOverWidgetState extends State<GameOverWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent
      ,
      body: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    const Text(
                      'Game Over',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    Text(
                      'You Score: ${widget.game.score}',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Restart',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () {
                        widget.game.overlays.remove(Constants.gameOver);
                        widget.game.overlays.add(Constants.hud);
                        widget.game.reset();
                        widget.game.resumeEngine();
                        // gameRef.startGamePlay();
                        // AudioManager.instance.resumeBgm();
                      },
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Exit',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () {
                        // gameRef.overlays.remove(GameOverMenu.id);
                        // gameRef.overlays.add(MainMenu.id);
                        // gameRef.resumeEngine();
                        // gameRef.reset();
                        // AudioManager.instance.resumeBgm();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
