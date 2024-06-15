import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/Design/colors.dart';

class NotificationRow extends StatelessWidget {
  final Map nObj;
  const NotificationRow({Key? key, required this.nObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(
            nObj["image"].toString(),
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nObj["title"].toString(),
                  style: TextStyle(
                    color: TColor.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                Text(
                  nObj["time"].toString(),
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/sub_menu.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
