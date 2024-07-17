import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mega_change_game/controller/score_controller.dart';
import 'package:mega_change_game/global.dart';
import 'package:mega_change_game/views/screens/game_screen.dart';
import 'package:mega_change_game/views/screens/setting_screen.dart';
import 'package:mega_change_game/views/widgets/custom_text.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../controller/sound_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    final box = GetStorage();
    first = box.read('first') ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (first == '') {
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Builder(builder: (context) {
            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return AlertDialog(
                  title: const CustomText(
                    text: 'Privacy Policy',
                    fontWeight: FontWeight.w500,
                  ),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Text(Global.policy,
                            style: const TextStyle(fontSize: 12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              activeColor: Colors.green,
                              side: BorderSide(
                                width: 1.5,
                                color: isChecked ? Colors.green : Colors.black,
                              ),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                  if (isChecked) {
                                    isAccepted = true;
                                  } else {
                                    isAccepted = false;
                                  }
                                });
                              },
                            ),
                            const CustomText(
                              text: 'I agreed to the Privacy Policy.',
                              size: 12,
                            )
                          ],
                        ),
                        ElevatedButton(
                          child: CustomText(
                            text: 'Accept',
                            size: 14,
                            textColor: Colors.white,
                          ),
                          onPressed: isAccepted
                              ? () {
                                  final box = GetStorage();
                                  box.write('first', 'notfirst');
                                  Navigator.pop(context);
                                }
                              : null,
                        ),
                      ],
                    )),
                  ),
                );
              },
            );
          }),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final soundConroller = Get.put(SoundController());
    final scoreController = Get.put(ScoreController());
    soundConroller.playSound();
    return Scaffold(
      body: Container(
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
                  const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(2), // Border radius
                        child: ClipOval(child: Icon(Icons.person)),
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(5), //border corner radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green
                                  .withOpacity(0.5), //color of shadow
                              spreadRadius: 5, //spread radius
                              blurRadius: 7, // blur radius
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            ),
                            //you can set more BoxShadow() here
                          ],
                        ),
                        child: CustomText(
                          text:
                              'Best Score :${scoreController.bestScore.value}',
                        )),
                  ),
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
                      Get.to(() => const SettingScreen());
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              NiceButtons(
                stretch: false,
                startColor: const Color.fromARGB(255, 138, 203, 141),
                endColor: Colors.green,
                borderColor: const Color.fromARGB(255, 31, 148, 35),
                gradientOrientation: GradientOrientation.Horizontal,
                onTap: (finish) {
                  Get.to(() => const GameScreen());
                },
                child: const CustomText(
                    text: 'Play',
                    textColor: Colors.white,
                    size: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              NiceButtons(
                stretch: false,
                startColor: const Color.fromARGB(255, 213, 127, 127),
                endColor: Colors.red,
                borderColor: const Color.fromARGB(255, 167, 25, 25),
                gradientOrientation: GradientOrientation.Horizontal,
                onTap: (finish) {
                  exit(0);
                },
                child: const CustomText(
                    text: 'Exit',
                    textColor: Colors.white,
                    size: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
