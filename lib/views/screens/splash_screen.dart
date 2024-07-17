import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mega_change_game/views/screens/home_screen.dart';
import 'package:mega_change_game/views/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/logo.webp',
              height: MediaQuery.of(context).size.height * 0.20,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: CustomText(
                text: 'Mega Change Game',
                size: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
          ),
          LoadingAnimationWidget.inkDrop(
            color: Colors.green,
            size: 27,
          ),
        ],
      ),
    );
  }
}
