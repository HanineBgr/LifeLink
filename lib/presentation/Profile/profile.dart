import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/EditProfilePage.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/Design/Round_Button.dart';
import 'package:glumate_flutter/presentation/Design/colors.dart';
import 'package:glumate_flutter/presentation/Design/title_subtitle.dart';
import 'package:glumate_flutter/presentation/Notification/SettingRow.dart';
import 'package:glumate_flutter/presentation/Register/role_widget.dart';
import 'package:glumate_flutter/presentation/Profile/contactUs.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
    final BuildContext context;

  const ProfileView({Key? key, required this.context}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegisterAuthProvider>(context, listen: false).eitherFailureOrConnectedCachedUser();
  }

  bool positive = false;

  List accountArr = [
    {"image": "assets/p_personal.png", "name": "Personal Data", "tag": "1", "route": EditProfilePage()},
    {"image": "assets/p_achi.png", "name": "Achievement", "tag": "2", "route": roleWidget()},
    {"image": "assets/p_workout.png", "name": "Activity History", "tag": "3", "route": null},
  ];

 List otherArr(BuildContext context) => [
  {"image": "assets/p_contact.png", "name":AppLocalization.of(context).translate('contact')!, "tag": "5", "route": ContactUsScreen()},
  {
    "image": "assets/p_privacy.png",
    "name": AppLocalization.of(context).translate('privacy')!,
    "tag": "6",
    "onTap": () {
      _showPrivacyDialog(context);
    },
  },
];


  String calculateAge(DateTime? birthDate) {
    if (birthDate == null) return 
    AppLocalization.of(context).translate('unknown')!;

    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age >= 0 ? age.toString() :AppLocalization.of(context).translate('unknown')!;
;
  }

  

  @override
  Widget build(BuildContext context) {
    var cachedUser = Provider.of<RegisterAuthProvider>(context, listen: false).cachedUser;
    String userAge = calculateAge(cachedUser != null ? DateTime.parse(cachedUser.dateOfBirth ?? '') : null);
  // String profileImage = getProfileImage(cachedUser != null ? cachedUser.gender : null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
       automaticallyImplyLeading: false,

        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: TColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Provider.of<RegisterAuthProvider>(context, listen: false).eitherFailureOrLogout();
              if (Provider.of<RegisterAuthProvider>(context, listen: false).errorLogoutMessage.isEmpty) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: () {
                  Provider.of<RegisterAuthProvider>(context, listen: false).eitherFailureOrLogout();
                  if (Provider.of<RegisterAuthProvider>(context, listen: false).errorLogoutMessage.isEmpty) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/avatarMale.PNG",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ahmed Salah",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Patient",
                          style: TextStyle(
                            color: TColor.gray,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 79,
                    height: 25,
                    child: RoundButton(
                      title: AppLocalization.of(context).translate('edit')!,
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "180cm",
                      subtitle: "Height",
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "65kg",
                      subtitle: "Weight",
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: userAge,
                      subtitle: "Age",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BluetoothDevicesView()),
                  );*/
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      AppLocalization.of(context).translate('compte')!,
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      for (var item in accountArr)
                        SizedBox(
                          height: 30,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => item["route"],
                                ),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item["image"],
                                  height: 15,
                                  width: 15,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    item["name"],
                                    style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              GestureDetector(
                onTap: () {
                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BluetoothDevicesView()),
                  );*/
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bluetooth",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/bluetooth.png",
                              height: 15,
                              width: 15,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                "Bluetooth Devices",
                                style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BluetoothDevicesView()),
                  );*/
                },
                child:
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          AppLocalization.of(context).translate('other')!,                
                          style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      for (var item in otherArr(context))
                        SizedBox(
                          height: 30,
                          child: GestureDetector(
                            onTap: () {
                              if (item['name'] == AppLocalization.of(context).translate('privacy')!               
) {
                                item['onTap']();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => item["route"],
                                  ),
                                );
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item["image"],
                                  height: 15,
                                  width: 15,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    item["name"],
                                    style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalization.of(context).translate('privacy')!,                
),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalization.of(context).translate('privacy_importance')!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 8.0),
                Text(
                    AppLocalization.of(context).translate('collect')!,
                      textAlign: TextAlign.justify,

                ),
                SizedBox(height: 16.0),
                Text(
                AppLocalization.of(context).translate('agree')!,
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.justify,

                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(               
                 AppLocalization.of(context).translate('close')!,
                ),
            ),
          ],
        );
      },
    );
  }
}
