import 'package:flutter/material.dart';
import 'package:glumate_flutter/data/models/article_model.dart';
import 'package:glumate_flutter/presentation/Articles/Articles.dart';
import 'package:glumate_flutter/presentation/Design/Round_Button.dart';
import 'package:glumate_flutter/presentation/Design/colors.dart';
import 'package:glumate_flutter/presentation/Design/styles/colors.dart';
import 'package:glumate_flutter/presentation/Design/styles/styles.dart';
import 'package:glumate_flutter/presentation/Notification/notificationView.dart';
import 'package:glumate_flutter/presentation/Doctor/TopDoctor.dart';
import 'package:lottie/lottie.dart';

class HomeTab extends StatelessWidget {
  final void Function() onPressedScheduleCard;

  const HomeTab({
    Key? key,
    required this.onPressedScheduleCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    List<ArticleModel> articles = [
      ArticleModel(
        imageAssetPath: 'assets/hospital.jpeg',
        title: "Astrazeneca breaking news ! ",
        location: "Read more",
        date: "2024-06-20 14:30",
        description: "Lorem ipsum dolor sit amet,consectetur adipiscing elit.",
      ),
      ArticleModel(
        imageAssetPath: 'assets/hospital.jpeg',
        title: 'Sample Article 2',
        location: 'Sample Location 2',
        date: '2024-06-21 15:45',
        description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
      ArticleModel(
        imageAssetPath: 'assets/hospital.jpeg',
        title: 'Sample Article 3',
        location: 'Sample Location 3',
        date: '2024-06-22 12:00',
        description: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
      ),
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: [
              SizedBox(height: 20),
              UserIntro(),
              SizedBox(height: 20),
              SearchInput(),
              SizedBox(height: 20),
              CategoryIcons(),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 205, 229, 249),
                      ),
                    ),
                    Positioned(
                      height: 180,
                      right: -15,
                      bottom: -10,
                      child: Lottie.asset('assets/Lottie/doc.json'),
                    ),
                    Positioned.fill(
                      top: 15,
                      left: 25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Early protection for \nyour family health!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 140,
                            child: FilledButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.indigo,
                              ),
                              onPressed: () {},
                              child: const Text("START"),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top doctors',
                    style: TextStyle(
                      color: Color(MyColors.header01),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Color(MyColors.blue),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              TopDoctor(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Health articles',
                    style: TextStyle(
                      color: Color(MyColors.header01),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Color(MyColors.blue),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticlesCard(articleModel: articles[index]);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


class ArticlesCard extends StatelessWidget {
  final ArticleModel articleModel;

  const ArticlesCard({
    required this.articleModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  articleModel.imageAssetPath,
                  fit: BoxFit.cover,
                  width: 60,
                  height: double.infinity,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articleModel.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Container(
                        child: Text(
                          articleModel.description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      articleModel.location,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // Handle save icon click
                // Implement your save logic here
                print('Save icon clicked');
              },
              child: Icon(
                Icons.bookmark,
                color: Color(MyColors.background), 
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary), 
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/doctor01.jpeg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dr.Muhammed Syahid',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Dental Specialist',
                              style: TextStyle(color: Color(MyColors.text01)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

List<Map> categories = [
  {'icon': Icons.coronavirus, 'text': 'Covid 19'},
  {'icon': Icons.local_hospital, 'text': 'Hospital'},
  {'icon': Icons.car_rental, 'text': 'Ambulance'},
  {'icon': Icons.local_pharmacy, 'text': 'Pill'},
];

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var category in categories)
          CategoryIcon(
            icon: category['icon'],
            text: category['text'],
          ),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg01),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Mon, July 29',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  IconData icon;
  String text;

  CategoryIcon({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: TColor.primaryColor2.withOpacity(0.4),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Color(MyColors.bs),
                size: 30,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 40, 
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Color.fromARGB(218, 91, 169, 233)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color.fromARGB(218, 91, 169, 233)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(218, 91, 169, 233)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(255, 107, 190, 150)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            labelText: 'Search a doctor or health issue',
            labelStyle: TextStyle(color: Colors.grey),
            errorStyle: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class UserIntro extends StatelessWidget {
  const UserIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hello',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Hanine Bouguerra 👋',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
     GestureDetector(
                   onTap: () {
                        Navigator.push(
                        context,
                         MaterialPageRoute(
                            builder: (context) => const NotificationView(),
                      ),
                       );
  },
  child: Image.asset(
    'assets/p_notification.png',
    width: 22,
    height:30,
    //fit: BoxFit.cover,
  ),
)


      ],
    );
  }
}
