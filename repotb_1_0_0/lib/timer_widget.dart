import 'dart:async';
import 'package:flutter/material.dart';

import '../services/questionnaire_timer.dart';

class TimerWidget extends StatefulWidget {

  const TimerWidget({
    super.key,
  });

  @override
  State<TimerWidget> createState() =>
      _TimerWidgetState();
}

class _TimerWidgetState
    extends State<TimerWidget> {

  late Timer timer;

  String elapsedTime = "00:00:00";

  @override
  void initState() {

    super.initState();

    _updateTimer();

    timer = Timer.periodic(

      const Duration(seconds: 1),

      (_) => _updateTimer(),
    );
  }

  void _updateTimer() {

    final difference =
        QuestionnaireTimer.getElapsed();

    final hours =
        difference.inHours
            .toString()
            .padLeft(2, '0');

    final minutes =
        difference.inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, '0');

    final seconds =
        difference.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');

    if (mounted) {

      setState(() {

        elapsedTime =
            "$hours:$minutes:$seconds";
      });
    }
  }

  @override
  void dispose() {

    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration: BoxDecoration(

        color: Colors.white.withOpacity(
          0.15,
        ),

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Text(

        elapsedTime,

        style: const TextStyle(

          fontSize: 20,

          fontWeight: FontWeight.bold,

          color: Colors.white,

          letterSpacing: 1,
        ),
      ),
    );
  }
}