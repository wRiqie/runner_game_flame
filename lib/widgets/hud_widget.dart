import 'package:flutter/material.dart';
import 'package:runner_flame_game/game/game.dart';

class HudWidget extends StatefulWidget {
  final DinoGame game;
  const HudWidget({super.key, required this.game});

  @override
  State<HudWidget> createState() => _HudWidgetState();
}

class _HudWidgetState extends State<HudWidget> {
  // bool isPaused = false;

  // void toggleIsPaused(bool value) {
  //   setState(() {
  //     isPaused = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            if (!widget.game.paused) {
              widget.game.pauseGame();
            }
          },
          icon: const Icon(
            Icons.pause,
            size: 30,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ValueListenableBuilder(
              valueListenable: widget.game.playerLife,
              builder: (context, value, child) {
                List<Widget> lifeHearts = [];

                for (var i = 0; i < 3; i++) {
                  lifeHearts.add(Icon(
                    Icons.favorite,
                    color: (value - 1) >= i ? Colors.red.withOpacity(0.7) : Colors.black54,
                  ));
                }

                return Row(
                  children: lifeHearts,
                );
              }),
        ),
      ],
    );
  }
}
