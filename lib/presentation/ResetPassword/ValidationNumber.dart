import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/ForgotPasswordPage.dart';
import 'package:glumate_flutter/presentation/pages/NewPasswordPage.dart';
import 'package:glumate_flutter/presentation/ResetPassword/NewPassword.dart';

class ValidationNumberScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/reset.png",
                height: 250,
                width: 300,
                fit: BoxFit.contain, 
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                            AppLocalization.of(context).translate('verify_code')!,     
                            style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberInputField(),
                  SizedBox(width: 10),
                  NumberInputField(),
                  SizedBox(width: 10),
                  NumberInputField(),
                  SizedBox(width: 10),
                  NumberInputField(),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomStyledButton(
                      () {
                       // if (_formKey.currentState!.validate()) 
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewPasswordPage(),
                    ),
                  );
                        
                      },
                      AppLocalization.of(context).translate('verify')!,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                AppLocalization.of(context).
                translate('not_verified')!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextButton(
                onPressed: () {
                 
                },
                child: Text(
                AppLocalization.of(context).
                translate('resend')!,         
                style: TextStyle(
                    color: Color.fromARGB(255, 87, 131, 167),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CustomStyledButton(Function onPressed, String buttonText) {
  return SizedBox(
    width: 200,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Color.fromARGB(255, 118, 183, 221),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
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

class NumberInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      child: TextField(
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counter: Offstage(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 107, 190, 150),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 118, 183, 221),
            ),
          ),
        ),
      ),
    );
  }
}
