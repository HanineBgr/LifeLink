import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/Design/styles/colors.dart';
import 'package:glumate_flutter/presentation/tabs/HomeTab.dart';
import 'package:glumate_flutter/presentation/tabs/ScheduleTab.dart';

class HomeView extends StatefulWidget {
  const HomeView ({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<HomeView> {
  int _selectedIndex = 0;
  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeTab(
        onPressedScheduleCard: goToSchedule,
      ),
      ScheduleTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
     
    );
  }
}
