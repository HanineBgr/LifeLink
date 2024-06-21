import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/Design/colors.dart';
import 'package:glumate_flutter/presentation/Notification/NotificationRow.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List notificationArr = [
    {
      "image": "assets/like.png",
      "title": "Hey, it’s time for lunch",
      "time": "About 1 minutes ago"
    },
    {
      "image": "assets/like.png",
      "title": "Don’t miss your lowerbody workout",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/like.png",
      "title": "Hey, let’s add some meals for your b",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/like.png",
      "title": "Congratulations, You have finished A..",
      "time": "29 May"
    },
    {
      "image": "assets/like.png",
      "title": "Hey, it’s time for lunch",
      "time": "8 April"
    },
    {
      "image": "assets/like.png",
      "title": "Ups, You have missed your Lowerbo...",
      "time": "8 April"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 213, 235, 255),
                Color.fromARGB(255, 248, 244, 246),
              ],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/black_btn.png",
                  width: 15,
                  height: 15,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(
              "Notification",
              style: TextStyle(
                color: TColor.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 213, 235, 255),
              Color.fromARGB(255, 248, 244, 246),
            ],
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          itemBuilder: ((context, index) {
            var nObj = notificationArr[index] as Map? ?? {};
            return NotificationRow(nObj: nObj);
          }),
          separatorBuilder: (context, index) {
            return Divider(
              color: TColor.gray.withOpacity(0.5),
              height: 1,
            );
          },
          itemCount: notificationArr.length,
        ),
      ),
    );
  }
}
