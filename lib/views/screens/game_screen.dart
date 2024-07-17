import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_change_game/controller/game_controller.dart';
import 'package:mega_change_game/views/screens/setting_screen.dart';
import 'package:mega_change_game/views/widgets/custom_text.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../controller/score_controller.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController());
    final scoreController = Get.put(ScoreController());
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Row(
                        children: [
                          NiceButtons(
                            width: 50,
                            height: 50,
                            borderRadius: 5,
                            stretch: false,
                            startColor:
                                const Color.fromARGB(255, 138, 203, 141),
                            endColor: Colors.green,
                            borderColor: const Color.fromARGB(255, 31, 148, 35),
                            gradientOrientation: GradientOrientation.Horizontal,
                            onTap: (finish) {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: gameController.score.value.toString(),
                          ),
                          CustomText(
                            text:
                                'Best Score :${scoreController.bestScore.value}',
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            CustomText(
                              text: gameController.timerText.value,
                              textColor: Colors.white,
                            ),
                          ],
                        )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.60,
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
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                            ),
                            itemCount: gameController.sportList.length,
                            itemBuilder: (context, index) {
                              return Visibility(
                                visible:
                                    gameController.sportList[index].isVisible ==
                                        true,
                                child: InkWell(
                                  onTap: gameController
                                              .sportList[index].isSelectable ==
                                          true
                                      ? () {
                                          gameController.merge(
                                              sport: gameController
                                                  .sportList[index],
                                              index: index);
                                        }
                                      : null,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        child: ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                              sigmaX: gameController
                                                          .sportList[index]
                                                          .isSelectable ==
                                                      false
                                                  ? 2
                                                  : 0,
                                              sigmaY: gameController
                                                          .sportList[index]
                                                          .isSelectable ==
                                                      false
                                                  ? 2
                                                  : 0),
                                          child: Image.asset(
                                            'assets/${gameController.sportList[index].value}.webp',
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: CustomText(
                                          text: gameController
                                              .sportList[index].value
                                              .toString(),
                                          textColor: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: gameController.mergeList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  width: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                    'assets/${gameController.mergeList[index].value}.webp',
                                  ))),
                                  child: Center(
                                    child: CustomText(
                                      text: gameController
                                          .mergeList[index].value
                                          .toString(),
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1.5,
                          ),
                        ],
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        gameController.pauseGame();
                      },
                      child: const Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NiceButtons(
                      width: 50,
                      height: 50,
                      borderRadius: 100,
                      stretch: false,
                      startColor: const Color.fromARGB(255, 138, 203, 141),
                      endColor: Colors.green,
                      borderColor: const Color.fromARGB(255, 31, 148, 35),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        gameController.resetGame();
                      },
                      child: const Icon(
                        Icons.replay,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
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
                        gameController.pauseGame();
                        Get.to(() => const SettingScreen());
                      },
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
