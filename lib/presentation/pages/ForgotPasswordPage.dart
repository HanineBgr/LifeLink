import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/ResetPassword/ForgotPassword.dart';
import 'package:glumate_flutter/presentation/Register/patient_register_form1.dart';
import 'package:glumate_flutter/presentation/Register/patient_register_form2_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int _currentPageIndex = 0;

  final TextEditingController _controllerEmail = TextEditingController();

  void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage = _currentPageIndex == 0
        ? ForgotPassword(
            controllerEmail: _controllerEmail,
          )
        : Consumer<RegisterAuthProvider>(
            builder: (context, registerProvider, _) => ForgotPassword(
              controllerEmail: _controllerEmail,
            ),
          );
    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalization.of(context).translate('reset')!),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 213, 235, 255),
                    const Color.fromARGB(255, 248, 244, 246),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 213, 235, 255),
                        const Color.fromARGB(255, 248, 244, 246),
                      ],
                    ),
                  ),
                  child: currentPage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSuccessNotification(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(
            AppLocalization.of(context).translate('account')!,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
