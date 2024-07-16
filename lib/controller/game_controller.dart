import 'dart:math';

import 'package:get/get.dart';
import 'package:mega_change_game/models/sport_model.dart';

class GameController extends GetxController {
  final score = 0.obs;
  final value = 0.obs;

  RxList<SportModel> sportList = <SportModel>[].obs;
  RxList<SportModel> mergeList = <SportModel>[].obs;

  @override
  void onInit() {
    generateRandom();
    super.onInit();
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
      if (mergeList.length > 2) {
        combineThreeRow();
      }
    }
  }

  void combineThreeRow() {
    for (int i = 0; i < mergeList.length; i++) {
      if (mergeList[i].value == mergeList[i + 1].value &&
          mergeList[i + 1].value == mergeList[i + 2].value) {
        value.value = mergeList[i].value! + 1;
        mergeList.removeAt(0);
        mergeList.removeAt(1);
        mergeList.removeAt(2);
        mergeList.add(SportModel(
          value: value.value,
          isVisible: false,
          isSelectable: false,
        ));
      }
    }
  }

  void resetGame() {
    score.value = 0;
    generateRandom();
    mergeList.value = [];
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
