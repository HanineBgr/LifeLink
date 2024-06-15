import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/Design/text_form_widget.dart';
import 'package:glumate_flutter/presentation/ResetPassword/Auth.dart';
import 'package:glumate_flutter/presentation/ResetPassword/DoneScreen.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  final TextEditingController controllerEmail;

  ForgotPassword({
    Key? key,
    required this.controllerEmail,
  }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; 

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
        return _isLoading ? _buildLoadingScreen() : _buildForm();
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            left: 28,
            right: 28,
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/mail.png",
                height: 300,
                width: 500,
              ),
              SizedBox(height: 40),
              Text(
                AppLocalization.of(context).translate('please_enter_email')!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25,),
              CustomTextFormField(
                label: AppLocalization.of(context).translate('email')!,
                controller: widget.controllerEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalization.of(context).translate('email_empty')!;
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return AppLocalization.of(context).translate('email_error')!;
                  }
                  return null;
                },
                icon: Icons.email,
              ),
              const SizedBox(height: 25),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomStyledButton(
                      () async {
                        if (_formKey.currentState!.validate()) {
                          _sendPasswordResetEmail();
                        }
                      },
                      AppLocalization.of(context).translate('envoyer')!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
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
          backgroundColor: Color.fromARGB(255, 118, 183, 221),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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

  void _sendPasswordResetEmail() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await AuthService().sendPasswordResetEmail(widget.controllerEmail.text.trim());
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DoneScreen()),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      showErrorMessage(error.toString());
    }
  }

  void showErrorMessage(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}



