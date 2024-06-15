import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/home_view.dart';
import 'package:glumate_flutter/presentation/login_form_widget.dart';
import 'package:glumate_flutter/presentation/main_tab.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthProvider>(builder: (context, authProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalization.of(context).translate('welcome_back')!),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [   Color.fromARGB(255, 213, 235, 255),
                const Color.fromARGB(255, 248, 244, 246),],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                Color.fromARGB(255, 213, 235, 255),
                const Color.fromARGB(255, 248, 244, 246),]    
                          ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginForm(
                  controllerEmail: _controllerEmail,
                  controllerPassword: _controllerPassword,
                  onLogin: () {
                    authProvider.eitherFailureOrLogin(
                      email: _controllerEmail,
                      passsword: _controllerPassword,
                    ).then((result) {
                      if (authProvider.errorLoginMessage.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authProvider.errorLoginMessage)),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainTabView()),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
