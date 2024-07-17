import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ScoreController extends GetxController {
  final bestScore = 0.obs;

  @override
  void onInit() {
    getBestScore();
    super.onInit();
  }

  void getBestScore() {
    final box = GetStorage();
    bestScore.value = box.read('bestScore') ?? 0;
  }
}
