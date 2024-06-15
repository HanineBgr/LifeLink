import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/pages/onBoarding2.dart';
import 'package:glumate_flutter/presentation/providers/Locale_provider.dart';
import 'package:glumate_flutter/presentation/Register/role_widget.dart';
import 'package:glumate_flutter/presentation/language_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()), 
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer2<LocaleProvider, ThemeProvider>(
        builder: (context, localeProvider, themeProvider, _) => Scaffold(
          body: _buildOnBoardingPage(context, themeProvider),
        ),
      ),
    );
  }

  Widget _buildOnBoardingPage(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 210, 233, 252),
            Color.fromARGB(255, 248, 244, 246),
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                      icon: Icon(
                        themeProvider.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                      icon: const Icon(Icons.language),
                      onPressed: () {
                        _showLanguageDialog(context);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/3d.png',
                      width: 300,
                      height: 400,
                    ),
                    Container(
                      height: 60,
                      width: 300,
                      child: FittedBox(
                        child: Text(
                          AppLocalization.of(context)
                              .translate('On_boarding_title1')!,
                          style: GoogleFonts.roboto(
                            fontSize: 100, 
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F394B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 100,
                      width: 220,
                      child: Text(
                        AppLocalization.of(context)
                            .translate('On_boarding_desc')!,
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: Color(0xFF8D8D8D),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
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
                    const SizedBox(height: 15),
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
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LocaleProvider>(
          builder: (context, localeProvider, _) => LanguageView(
            (newLocale) {
              localeProvider.setLocale(newLocale);
            },
          ),
        );
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
