import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/ForgotPasswordPage.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/Locale_provider.dart';
import 'package:glumate_flutter/presentation/ResetPassword/ForgotPassword.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  bool isBlurred = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) => Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/sent.png',
                      width: 340,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      width: 300,
                      child: FittedBox(
                        child: Text(
                          AppLocalization.of(context)
                              .translate('pass_sent')!,
                          style: GoogleFonts.roboto(
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F394B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 1),
                    Container(
                      height: 100,
                      width: 300,
                      child: Text(
                        AppLocalization.of(context)
                            .translate('pass_desc')!,
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: Color(0xFF8D8D8D)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 20,
                          backgroundColor:
                              Color.fromARGB(255, 118, 183, 221),
                          shadowColor: const Color.fromARGB(255, 144, 198, 243)
                              .withOpacity(1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            AppLocalization.of(context)
                                .translate('done')!,
                            style: GoogleFonts.roboto(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                 Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),);
                },
                child: Text(
                AppLocalization.of(context).
                translate('resend')!,         
                style: TextStyle(
                    color: Color.fromARGB(255, 110, 160, 200),
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
              ),                  
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
