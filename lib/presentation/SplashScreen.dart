import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/pages/onboarding_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.6,
                 child: LottieBuilder.asset("assets/Lottie/Splash1.json"),
                ),
              ],
            ),
            nextScreen: const OnBoardingPage(),
            splashIconSize: 10,
            backgroundColor: Color.fromARGB(218, 202, 228, 247),
          ),
        ),
      ),
    );
  }
}
