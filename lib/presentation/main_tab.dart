import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/Chat/chat_widget.dart';
import 'package:glumate_flutter/presentation/Notification/notificationView.dart';
import 'package:glumate_flutter/presentation/Profile/profile.dart';
import 'package:glumate_flutter/presentation/home_view.dart';
import 'package:glumate_flutter/presentation/tabs/HomeTab.dart';
import 'package:glumate_flutter/presentation/tabs/ScheduleTab.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _page = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color.fromARGB(255, 205, 229, 249),
        color: Color.fromARGB(255, 205, 229, 249),
        animationDuration: const Duration(milliseconds: 300),
        index: _page,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.message, size: 30, color: Colors.white),
          Icon(Icons.calendar_month, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
        children: const <Widget>[
          HomeView(),
          MyChatUI(),
          ScheduleTab(),
          ProfileView(),
        ],
      ),
    );
  }
}