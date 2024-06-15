import 'package:flutter/material.dart';

import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';
import 'package:glumate_flutter/presentation/SplashScreen.dart';
import 'package:glumate_flutter/presentation/pages/home_page/pages/home_page.dart';
import 'package:glumate_flutter/presentation/pages/onboarding_page.dart';
import 'package:glumate_flutter/presentation/main_tab.dart';

class WidgetTree extends StatefulWidget {
const WidgetTree({Key? key}) : super(key: key);

@override
State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, 
      builder: (context , snapshot) {
        if (snapshot.hasData) {
          return MainTabView();
        } else {
          return const SplashScreen();
        }
      },
      );
  }


}