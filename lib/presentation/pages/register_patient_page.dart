import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/Register/patient_register_form1.dart';
import 'package:glumate_flutter/presentation/Register/patient_register_form2_widget.dart';
import 'package:provider/provider.dart';

class RegisterPatientPage extends StatefulWidget {
  const RegisterPatientPage({Key? key}) : super(key: key);

  @override
  State<RegisterPatientPage> createState() => _registerPatientPageState();
}

class _registerPatientPageState extends State<RegisterPatientPage> {
    int _currentPageIndex = 0;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
   int _selectedGender = 1;
  DateTime _selectedDate = DateTime.now();


      void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget currentPage = _currentPageIndex == 0 ? registerForm1(
            controllerName: _controllerName,
            controllerLastName: _controllerLastName,
            selectedGender: _selectedGender,
            selectedDate: _selectedDate,
            onNextPressed: (selectedGender,selectedDate) {
              setState(() {
                _currentPageIndex = 1;
                    _selectedGender = selectedGender;
                    _selectedDate = selectedDate;

              });
            },
          ) 
          :  Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) => RegisterForm2(
            controllerEmail: _controllerEmail,
            controllerPassword: _controllerpassword,
            onFinish: ()  {
    
             registerProvider.eitherFailureOrRegister(
              firstName: _controllerName ,
               lastName : _controllerLastName ,
                email : _controllerEmail ,
                 password : _controllerpassword , 
                  selectedDate : _selectedDate, 
                  selectedgender: _selectedGender, 
                  selectedGender: _selectedGender).then((_)  {
                     
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
            title: Text(AppLocalization.of(context).translate('join_patients')!),
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
          body: currentPage,
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