import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/Design/text_form_widget.dart';

class RegisterForm2 extends StatefulWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final VoidCallback? onFinish;
  final VoidCallback? onBack;

  RegisterForm2({
    Key? key,
    required this.controllerEmail,
    required this.controllerPassword,
    this.onFinish,
    this.onBack,
  }) : super(key: key);

  @override
  _RegisterForm2State createState() => _RegisterForm2State();
}

class _RegisterForm2State extends State<RegisterForm2> {
  String? password;
  RegExp get _emailRegex =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controllerpasswordconfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/subscribe.png", 
              height: 250,
              width: 460,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      label: AppLocalization.of(context)
                          .translate('email')!,
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
      return AppLocalization.of(context).translate('password_empty')!;
    } else {
      if (value.length < 6) {
        return AppLocalization.of(context).translate('password_error')!;
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
const SizedBox(height: 20),
CustomTextFormField(
  label: AppLocalization.of(context).translate('confirm_password')!,
  controller: _controllerpasswordconfirm,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context).translate('confirm_password_empty')!;
    } else {
      if (value != password) {
        return AppLocalization.of(context)
            .translate('confirm_password_error')!;
      }
    }
    return null;
  },
  icon: Icons.password,
),

                    const SizedBox(height: 30),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(218, 91, 169, 233),
                            minimumSize: Size(150, 50), 
                          ),
                          onPressed: () {
                            widget.onBack!();
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate('previous')!,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(218, 91, 169, 233),
                            minimumSize: Size(150, 50), 
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onFinish!();
                            }
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate('next')!,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}