import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:timerklikacc/controller/controller.dart';
import 'package:timerklikacc/views/mainpage/real_core.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CountDownController controller = CountDownController();
  final timer = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<TimerController>(
                init: TimerController(),
                initState: (cont) {},
                builder: (cont) {
                  return SizedBox(
                    width: Get.width / 1.1,
                    height: Get.height / 3,
                    child: NeonCircularTimer(
                      onComplete: () {
                        if (kDebugMode) {
                          print('selesai');
                        }
                      },
                      width: 200,
                      duration: cont.countdown.toInt(),
                      controller: controller,
                      isTimerTextShown: true,
                      neumorphicEffect: true,
                      isReverse: true,
                      isReverseAnimation: true,
                      innerFillGradient: LinearGradient(colors: [
                        Colors.greenAccent.shade200,
                        Colors.blueAccent.shade400
                      ]),
                      neonGradient: LinearGradient(colors: [
                        Colors.greenAccent.shade200,
                        Colors.blueAccent.shade400
                      ]),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width / 11,
                    height: Get.height / 15,
                    child: const Center(child: Text('0')),
                  ),
                  GetBuilder<TimerController>(
                    init: TimerController(),
                    initState: (cont) {},
                    builder: (cont) {
                      return SizedBox(
                        width: Get.width / 1.3,
                        height: Get.height / 15,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Slider(
                                    activeColor: Colors.greenAccent.shade400,
                                    inactiveColor: Colors.greenAccent.shade100,
                                    value: cont.countdown.toDouble(),
                                    min: 0,
                                    max: 60,
                                    divisions: 60,
                                    label: cont.countdown.toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        cont.countdown = value as RxInt;
                                      });
                                      Get.find<TimerController>()
                                          .updateCountdown(value.toInt());
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: Get.width / 11,
                    height: Get.height / 15,
                    child: const Center(child: Text('60')),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width / 3.5,
                    height: Get.height / 15,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.start();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Start'),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3.5,
                    height: Get.height / 15,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const SleekTimer());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Go To There'),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3.5,
                    height: Get.height / 15,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.restart();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Reset')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
