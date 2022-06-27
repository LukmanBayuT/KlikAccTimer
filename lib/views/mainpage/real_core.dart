import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SleekTimer extends StatefulWidget {
  const SleekTimer({Key? key}) : super(key: key);

  @override
  SleekTimerState createState() => SleekTimerState();
}

class SleekTimerState extends State<SleekTimer> {
  static const countdownDuration = Duration(minutes: 1);
  Duration duration = const Duration();
  Timer? timer;
  final bool _isCountDown = true;
  late Timer _timer;
  int _start = 60;
  int seconds = 60;
  var _isTimerOn = false;

  // void startTimerX() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  // }

  // void resetX() {
  //   if (_isCountDown) {
  //     setState(() {
  //       duration = countdownDuration;
  //     });
  //   } else {
  //     setState(() {
  //       duration = const Duration();
  //     });
  //   }
  // }

  // void addTime() {
  //   final addSeconds = _isCountDown ? -1 : 1;

  //   setState(() {
  //     final seconds = duration.inSeconds + addSeconds;
  //     if (seconds < 0) {
  //       timer?.cancel();
  //     } else {
  //       duration = Duration(seconds: seconds);
  //     }
  //   });
  // }

  void reset() {
    if (_isCountDown) {
      setState(() {
        duration = countdownDuration;
      });
    } else {
      setState(() {
        duration = const Duration();
      });
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 60);
    setState(() {
      _isTimerOn = true;
    });
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.greenAccent.shade200,
              Colors.blueAccent.shade400
            ])),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.85,
              height: Get.width * 0.85,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  size: Get.width * 0.84,
                  customColors: CustomSliderColors(
                    trackColor: Colors.white,
                    progressBarColor: Colors.greenAccent.shade200,
                    dotColor: Colors.blueAccent.shade400,
                    shadowColor: Colors.greenAccent.shade200,
                  ),
                  startAngle: 270,
                  angleRange: 360,
                  customWidths: CustomSliderWidths(
                    trackWidth: 36,
                    progressBarWidth: 22,
                    handlerSize: 7,
                  ),
                ),
                min: 0,
                max: 60,
                initialValue: _start.toDouble(),
                onChange: (double value) {
                  setState(() {
                    _start = value.round();
                    if (_start == 0) {
                      Get.snackbar('Finish', 'Brahhh');
                    }
                  });
                },
                innerWidget: (percentage) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_start.round()}',
                        style: const TextStyle(
                          fontSize: 120,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "minutes",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                'time',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Second',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 140,
            ),
            SizedBox(
              width: Get.width / 3.5,
              height: Get.height / 15,
              child: ElevatedButton(
                onPressed: () {
                  if (_isTimerOn) {
                    _timer.cancel();
                    setState(() {
                      _isTimerOn = false;
                      _start = 30;
                    });
                  } else {
                    _isTimerOn = true;
                    startTimer();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      // ignore: use_full_hex_values_for_flutter_colors
                      _isTimerOn ? Colors.redAccent : const Color(0xfff24ffcc),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  _isTimerOn ? 'Stop' : 'Start',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    // ignore: unused_local_variable
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // buildTimeCard(time: minutes, header: 'MINUTES'),
        // const SizedBox(
        //   width: 8,
        // ),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                time,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            header,
            style: const TextStyle(color: Colors.white),
          )
        ],
      );
}
