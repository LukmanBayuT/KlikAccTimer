import 'package:get/get.dart';

class TimerController extends GetxController {
  RxInt countdown = 10.obs;

  updateCountdown(int count) {
    countdown = count as RxInt;
    update();
  }
}
