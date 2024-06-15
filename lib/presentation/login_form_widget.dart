import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/ForgotPasswordPage.dart';
import 'package:glumate_flutter/presentation/Design/text_form_widget.dart';
import 'package:glumate_flutter/presentation/ResetPassword/ForgotPassword.dart';
import 'package:glumate_flutter/presentation/home_view.dart';
import 'package:glumate_flutter/presentation/main_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final VoidCallback? onLogin;

  LoginForm({
    Key? key,
    this.onLogin,
    required this.controllerEmail,
    required this.controllerPassword,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? password;
  RegExp get _emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/login.png",
                  height: 300,
                  width: 450,
                ),
                CustomTextFormField(
                  label: AppLocalization.of(context).translate('email')!,
                  controller: widget.controllerEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalization.of(context)
                          .translate('email_empty')!;
                    } else {
                      if (!_emailRegex.hasMatch(value)) {
                        return AppLocalization.of(context)
                            .translate('email_error')!;
                      }
                    }
                    return null;
                  },
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  label: AppLocalization.of(context).translate('password')!,
                  controller: widget.controllerPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalization.of(context)
                          .translate('password_empty')!;
                    } else {
                      if (value.length < 6) {
                        return AppLocalization.of(context)
                            .translate('password_error')!;
                      }
                    }
                    return null;
                  },
                  icon: Icons.password,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(height: 25),
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomStyledButton(
                            () {
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainTabView(),
                            ),
                          );
                            },
                            AppLocalization.of(context).translate('sign_in')!,
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Color.fromARGB(235, 169, 167, 167),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              AppLocalization.of(context).translate('or')!,
                              style: TextStyle(
                                color: Color.fromARGB(255, 103, 162, 211),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Color.fromARGB(235, 169, 167, 167),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 270,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(161, 144, 144, 145),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: Image.asset(
                                'assets/google.png',
                                width: 25,
                                height: 30,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              AppLocalization.of(context).translate('google')!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 76, 139, 175),
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalization.of(context)
                              .translate('forgot_password')!,
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
          ),
        ],
      ),
    );
  }

  Widget CustomStyledButton(Function onPressed, String buttonText) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 76, 139, 175),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      print('User signed in with Google: ${user?.displayName}');

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }
}
