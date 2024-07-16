import 'package:flutter/material.dart';
import 'package:mega_change_game/views/screens/setting_screen.dart';
import 'package:mega_change_game/views/widgets/custom_text.dart';
import 'package:nice_buttons/nice_buttons.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(5), //border corner radius
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.green.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset:
                              const Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    child: const CustomText(
                      text: 'Best Score :' '300',
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(5), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.green.withOpacity(0.5), //color of shadow
                            spreadRadius: 2, //spread radius
                            blurRadius: 2, // blur radius
                            offset: const Offset(
                                0, 1), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Colors.white,
                          ),
                          const CustomText(
                            text: '01:00',
                            textColor: Colors.white,
                          ),
                        ],
                      )),
                ],
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
                      //
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
                      //
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingScreen()),
                      );
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
    );
  }
}
