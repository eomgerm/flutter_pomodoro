import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  late Timer timer;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 1) {
      setState(() {
        totalPomodoros++;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(
        () {
          totalSeconds--;
        },
      );
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRestartPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = 1500;
    });
  }

  String formatSecondstoMinutes(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                formatSecondstoMinutes(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                ),
                IconButton(
                  icon: const Icon(Icons.replay_outlined),
                  onPressed: onRestartPressed,
                  color: Theme.of(context).cardColor,
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodors',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
