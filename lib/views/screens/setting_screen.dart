import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:mega_change_game/views/widgets/custom_text.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../controller/sound_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final soundController = Get.put(SoundController());
    return Scaffold(
      body: Obx(
        () => Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.webp"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NiceButtons(
                      width: 50,
                      height: 50,
                      borderRadius: 5,
                      stretch: false,
                      startColor: const Color.fromARGB(255, 138, 203, 141),
                      endColor: Colors.green,
                      borderColor: const Color.fromARGB(255, 31, 148, 35),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const CustomText(
                      text: 'Settings',
                      fontWeight: FontWeight.bold,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 138, 203, 141),
                              Colors.green
                            ]),
                      ),
                      // decoration: const BoxDecoration(
                      //     color: Color.fromARGB(255, 138, 203, 141),
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Icon(
                        Icons.vibration,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const CustomText(text: 'Sound'),
                    const Spacer(),
                    FlutterSwitch(
                      padding: 1.5,
                      height: 23,
                      width: 44,
                      inactiveColor: Colors.grey, //const Color(0xFFE0E0E0),
                      activeColor: Colors.green,
                      value: soundController.isMuted.value,
                      onToggle: (val) {
                        soundController.isMuted.value = val;
                        soundController.muteUnmute();
                      },
                    ),
                  ],
                ),
                const Spacer(),
                const CustomText(text: 'version 1.0.0'),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
