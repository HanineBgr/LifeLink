import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:glumate_flutter/presentation/Chat/chat_widget.dart';
import 'package:glumate_flutter/presentation/Profile/profile.dart';
import 'package:glumate_flutter/presentation/tabs/ScheduleTab.dart';
import 'home_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _selectedIndex = 0;
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
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: [
          HomeView(),
          MyChatUI(),
          ScheduleTab(),
          ProfileView(context: context,),  
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Color.fromARGB(255, 141, 108, 240),
      strokeColor: Color(0x30040307),
      unSelectedColor: Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.chat),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          _pageController.jumpToPage(index); 
        });
      },
    );
  }
}
