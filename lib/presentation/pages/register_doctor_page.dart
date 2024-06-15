import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/Register/doctor_register_form1.dart';
import 'package:glumate_flutter/presentation/Register/doctor_register_form2.dart';
import 'package:provider/provider.dart';

class RegisterDoctorPage extends StatefulWidget {
  const RegisterDoctorPage({Key? key}) : super(key: key);

  @override
  State<RegisterDoctorPage> createState() => _registerDoctorPageState();
}

class _registerDoctorPageState extends State<RegisterDoctorPage> {
    int _currentPageIndex = 0;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controllerconfirmpassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();



      void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget currentPage = _currentPageIndex == 0 ? registerDoctorForm1(
            controllerName: _controllerName,
            controllerLastName: _controllerLastName,
            controllerPhone: _controllerPhone,
            controllerEmail: _controllerEmail,
            onNextPressed: () {
              setState(() {
                _currentPageIndex = 1;

              });
            },
          ) 
          :  Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) => RegisterDoctorForm2(
            controllerConfirmPassword: _controllerconfirmpassword,
            controllerPassword: _controllerpassword,
            onFinish: ()  {
    
             registerProvider.eitherFailureOrRegisterCareProvider(
              firstName: _controllerName ,
               lastName : _controllerLastName ,
                email : _controllerEmail ,
                 password : _controllerpassword, 
                 phone: _controllerPhone , 
                 ).then((_)  {
                     
        if (registerProvider.errorRegisterMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(registerProvider.errorRegisterMessage)),
          );
        } else {
         showSuccessNotification(context, "Success");

        }
                  });
                
            },
             onBack: () {
              setState(() {
                _currentPageIndex = 0;
              });
            },
      )
          );
       return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
      return Scaffold(
      appBar: AppBar(
            title: Text(AppLocalization.of(context).translate('join_doctors')!),
            flexibleSpace: Container(
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
            ),
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
              Navigator.of(context).pop(); 
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );


}}