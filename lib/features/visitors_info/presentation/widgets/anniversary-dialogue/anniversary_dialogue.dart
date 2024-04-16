import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class AnniversaryDialogue extends StatefulWidget {
  const AnniversaryDialogue({super.key, required this.visitorNumber});

  final int visitorNumber;

  @override
  State<AnniversaryDialogue> createState() => _AnniversaryDialogueState();
}

class _AnniversaryDialogueState extends State<AnniversaryDialogue> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _confettiController.play();
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            // Фоновые конфетти
            Align(
              alignment: Alignment.topCenter.add(const Alignment(0, -1)),
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                minBlastForce: 250,
                maxBlastForce: 300,
                emissionFrequency: 0.05,
                minimumSize: const Size(10, 10),
                maximumSize: const Size(50, 50),
                numberOfParticles: 5,
                gravity: 1,
              ),
            ),
            // Основной текст
            Padding(
              padding: const EdgeInsets.all(350.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Поздравляем!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // fontSize: 28
                      ),
                    ),
                    RichText(
                      text: TextSpan(text: 'Вы наш ', children: <TextSpan>[
                        TextSpan(
                          text: widget.visitorNumber.toString(),
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const TextSpan(text: ' посетитель!')
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            // Конфетти на переднем плане
            Align(
              alignment: Alignment.topCenter.add(const Alignment(0, -1)),
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                minBlastForce: 250,
                maxBlastForce: 300,
                emissionFrequency: 0.3,
                minimumSize: const Size(10, 10),
                maximumSize: const Size(50, 50),
                numberOfParticles: 5,
                gravity: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
