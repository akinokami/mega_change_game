import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mega_change_game/controller/score_controller.dart';
import 'package:mega_change_game/controller/sound_controller.dart';
import 'package:mega_change_game/models/sport_model.dart';
import 'package:mega_change_game/views/widgets/custom_text.dart';
import 'package:nice_buttons/nice_buttons.dart';

class GameController extends GetxController {
  final score = 0.obs;
  final value = 0.obs;
  final delInxex = 0.obs;

  RxList<SportModel> sportList = <SportModel>[].obs;
  RxList<SportModel> mergeList = <SportModel>[].obs;

  var start = 60;
  Timer? timer;
  var isCountingDown = false.obs;

  RxString timerText = '01:00'.obs;

  @override
  void onInit() {
    generateRandom();
    super.onInit();
  }

  @override
  void onReady() {
    playDialog();
    super.onReady();
  }

  void startTimer() {
    isCountingDown.value = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start == 0) {
        isCountingDown.value = false;
        timer.cancel();
        timeOutDialog();
      } else {
        start--;
        timerText.value = '00:${start < 10 ? '0$start' : start}';
      }
    });
  }

  void generateRandom() {
    sportList.clear();
    for (int i = 0; i < 25; i++) {
      sportList.add(SportModel(
        id: i + 1,
        value: i > 19 ? Random().nextInt(2) + 1 : Random().nextInt(4) + 1,
        isVisible: true,
        isSelectable: i > 19 ? true : false,
      ));
    }
  }

  void merge({required SportModel sport, required int index}) {
    if (mergeList.length < 7) {
      mergeList.add(sport);
      sportList[index].isVisible = false;
      if (index > 4) {
        sportList[index - 5].isSelectable = true;
      }
      combineAndDeleteThreeConsecutive();
    }
  }

  void combineAndDeleteThreeConsecutive() {
    List<SportModel> combinedList = [];
    int i = 0;
    bool isRecall = false;
    while (i < mergeList.length) {
      SportModel current = mergeList[i];
      int count = 0;
      // Count consecutive same items
      while (i < mergeList.length &&
          mergeList[i].value == current.value &&
          count < 3) {
        count++;
        i++;
      }
      // If found 3 or more consecutive items, combine and delete
      if (count >= 3) {
        // combinedList.add('$current (x$count)');
        combinedList.add(SportModel(
          value: current.value! + 1,
          isVisible: false,
          isSelectable: false,
        ));
        if (current.value == 1) {
          score.value += 10;
        } else if (current.value == 2) {
          score.value += 20;
        } else if (current.value == 3) {
          score.value += 30;
        } else if (current.value == 4) {
          score.value += 40;
        } else if (current.value == 5) {
          score.value += 50;
        } else {
          score.value += 60;
        }
        isRecall = true;
      } else {
        // Otherwise, add individual items
        for (int j = 0; j < count; j++) {
          combinedList.add(mergeList[i - count + j]);
        }
      }
    }
    mergeList.value = combinedList;
    if (isRecall) {
      combineAndDeleteThreeConsecutive();
    } else {
      calculateFinish();
    }
  }

  void calculateFinish() {
    if (mergeList.length == 7 ||
        sportList.where((i) => i.isVisible == true).toList().isEmpty) {
      timer?.cancel();
      finishDialog();
    }
  }

  void finishDialog() {
    if (Get.find<ScoreController>().bestScore.value < score.value) {
      final box = GetStorage();
      box.write('bestScore', score.value);
      Get.find<ScoreController>().getBestScore();
    }
    Get.defaultDialog(
        title: "Mega Change",
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        barrierDismissible: false,
        radius: 10,
        content: Column(
          children: [
            CustomText(text: 'Score: ${score.value}', size: 16),
            const SizedBox(height: 10),
            CustomText(text: timerText.value, size: 16),
            const SizedBox(height: 30),
            NiceButtons(
              stretch: false,
              height: 40,
              width: 150,
              startColor: const Color.fromARGB(255, 138, 203, 141),
              endColor: Colors.green,
              borderColor: const Color.fromARGB(255, 31, 148, 35),
              gradientOrientation: GradientOrientation.Horizontal,
              onTap: (finish) {
                Get.find<SoundController>().vibrate();
                Get.back();
              },
              child: const CustomText(
                  text: 'Close',
                  textColor: Colors.white,
                  size: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  void playDialog() {
    Get.defaultDialog(
        title: "",
        backgroundColor: Colors.transparent,
        titleStyle: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        barrierDismissible: false,
        radius: 10,
        onWillPop: () async {
          Get.find<SoundController>().vibrate();
          startTimer();
          Get.back();
          return false;
        },
        content: Column(
          children: [
            NiceButtons(
              stretch: false,
              height: 70,
              width: 70,
              borderRadius: 100,
              startColor: const Color.fromARGB(255, 138, 203, 141),
              endColor: Colors.green,
              borderColor: const Color.fromARGB(255, 31, 148, 35),
              gradientOrientation: GradientOrientation.Horizontal,
              onTap: (finish) {
                Get.find<SoundController>().vibrate();
                startTimer();
                Get.back();
              },
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }

  void timeOutDialog() {
    Get.defaultDialog(
        title: "Time Out",
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        barrierDismissible: false,
        radius: 10,
        onWillPop: () async {
          Get.find<SoundController>().vibrate();
          resetGame();
          Get.back();
          return false;
        },
        content: Column(
          children: [
            const Icon(Icons.timer_outlined, color: Colors.black, size: 50),
            const SizedBox(height: 30),
            NiceButtons(
              stretch: false,
              height: 40,
              width: 150,
              startColor: const Color.fromARGB(255, 138, 203, 141),
              endColor: Colors.green,
              borderColor: const Color.fromARGB(255, 31, 148, 35),
              gradientOrientation: GradientOrientation.Horizontal,
              onTap: (finish) {
                Get.find<SoundController>().vibrate();
                resetGame();
                Get.back();
              },
              child: const CustomText(
                  text: 'Retry',
                  textColor: Colors.white,
                  size: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  void resetGame() {
    score.value = 0;
    generateRandom();
    mergeList.clear();
    timer?.cancel();
    timerText = '01:00'.obs;
    start = 60;
    startTimer();
  }

  void pauseGame() {
    timer?.cancel();
    playDialog();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
