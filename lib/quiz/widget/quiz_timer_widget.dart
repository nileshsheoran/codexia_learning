import 'dart:async';

import 'package:flutter/material.dart';

class QuizTimerWidget extends StatefulWidget {
  const QuizTimerWidget({
    super.key,
  });

  @override
  State<QuizTimerWidget> createState() => _QuizTimerWidgetState();
}

class _QuizTimerWidgetState extends State<QuizTimerWidget> {
  var isLoaded = false;
  int seconds = 60;
  Timer? timer;
  bool isPaused = false;

  @override
  void dispose() {
    // timer!.cancel();
     // pauseTimer();
    setState(() {
      isPaused = true;
      timer!.cancel();
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
    });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0 && !isPaused) {
          seconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
      timer!.cancel();
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '$seconds',
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: seconds / 60,
                valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
              ),
            ),
            // ElevatedButton(
            //   onPressed: pauseTimer, // Add a button to stop the timer
            //   child: const Text('Stop Timer'),
            // ),
          ],
        ),
      ],
    );
  }
}
