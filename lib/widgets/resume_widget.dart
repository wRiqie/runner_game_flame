import 'package:flutter/material.dart';
import 'package:runner_flame_game/core/constants.dart';
import 'package:runner_flame_game/game/game.dart';

class ResumeWidget extends StatefulWidget {
  final DinoGame game;
  const ResumeWidget({super.key, required this.game});

  @override
  State<ResumeWidget> createState() => _ResumeWidgetState();
}

class _ResumeWidgetState extends State<ResumeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(6)
        ),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Paused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            IconButton(
              onPressed: widget.game.resumeGame,
              icon: const Icon(
                Icons.play_arrow,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
