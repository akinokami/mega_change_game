import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mega_change_game/controller/sound_controller.dart';
import 'package:mega_change_game/views/widgets/custom_text.dart';
import 'package:nice_buttons/nice_buttons.dart';

class ProfileController extends GetxController {
  RxList<String> avatorList = <String>[].obs;
  final selectedAvator = ''.obs;

  @override
  void onInit() {
    getProfile();
    getAvator();
    super.onInit();
  }

  void getProfile() {
    final box = GetStorage();
    selectedAvator.value = box.read('avator') ?? 'assets/1.webp';
    box.write('avator', selectedAvator.value);
  }

  void getAvator() {
    avatorList.addAll([
      'assets/1.webp',
      'assets/2.webp',
      'assets/3.webp',
      'assets/4.webp',
      'assets/5.webp',
      'assets/6.webp',
    ]);
  }

  void chooseAvator(String avator) {
    selectedAvator.value = avator;
    final box = GetStorage();
    box.write('avator', selectedAvator.value);
  }

  void avatorDialog() {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 20),
        title: "Choose Avator",
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        barrierDismissible: false,
        radius: 10,
        content: SizedBox(
          height: 200,
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount: avatorList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.find<SoundController>().vibrate();
                          chooseAvator(avatorList[index]);
                          Get.back();
                        },
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            avatorList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
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
          ),
        ));
  }
}
