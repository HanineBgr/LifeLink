import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/Locale_provider.dart';
import 'package:glumate_flutter/presentation/Register/role_widget.dart';
import 'package:glumate_flutter/presentation/language_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnBoardingPage2 extends StatefulWidget {
  const OnBoardingPage2({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage2> createState() => _OnBoardingPage2State();
}

class _OnBoardingPage2State extends State<OnBoardingPage2> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(255, 210, 233, 252),
                const Color.fromARGB(255, 248, 244, 246),
              ],
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/3d.png',
                          width: 700,
                          height: 400,
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 50,
                          width: 300,
                          child: FittedBox(
                            child: Text(
                              AppLocalization.of(context)
                                  .translate('On_boarding_title')!,
                              style: GoogleFonts.roboto(
                                fontSize: 50,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2F394B),
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 100,
                          width: 250,
                          child: Text(
                            AppLocalization.of(context)
                                .translate('On_boarding_desc')!,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color(0xFF8D8D8D),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                         SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => roleWidget(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 20,
                              backgroundColor:
                                  Color.fromARGB(255, 118, 183, 221),
                              shadowColor:
                                  const Color.fromARGB(255, 144, 198, 243)
                                      .withOpacity(1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                AppLocalization.of(context)
                                    .translate('Get_started')!,
                                style: GoogleFonts.roboto(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate('already_memeber')!,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Color.fromARGB(255, 76, 139, 175),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Row(
                  children: List.generate(2, (index) {
                    return Container(
                      margin: EdgeInsets.only(right: 8.0),
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPageIndex == index
                            ? Colors.black
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  
  
}
