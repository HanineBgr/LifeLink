import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/ResetPassword/ForgotPassword.dart';
import 'package:glumate_flutter/presentation/Register/patient_register_form1.dart';
import 'package:glumate_flutter/presentation/Register/patient_register_form2_widget.dart';
import 'package:glumate_flutter/presentation/ResetPassword/NewPassword.dart';
import 'package:provider/provider.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
    int _currentPageIndex = 0;

  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();



      void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget currentPage = _currentPageIndex == 0 ? NewPassword(
            controllerPassword: _controllerPassword, 
            controllerConfirmPassword: _controllerConfirmPassword,
           
          ) 
          :  Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) => NewPassword(
            controllerPassword: _controllerPassword, 
            controllerConfirmPassword: _controllerConfirmPassword,            
      )
          );
       return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
  return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalization.of(context).translate('reset')!),
      ),
      body: currentPage
       );
      }
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
            onPressed: () {
             
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );


}}