import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/Design/text_form_widget.dart';
import 'package:glumate_flutter/presentation/ResetPassword/ValidationNumber.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatefulWidget {
  final TextEditingController controllerPassword;
  final TextEditingController controllerConfirmPassword;

  NewPassword({
    Key? key,
    required this.controllerConfirmPassword,
    required this.controllerPassword,
  }) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 40,
                left: 28,
                right: 28,
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/pass.gif",
                    height: 300,
                    width: 500,
                  ),
                  SizedBox(height: 25),
                  Text(
                    AppLocalization.of(context).translate('update_password')!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomTextFormField(
                    label: AppLocalization.of(context).translate('password')!,
                    controller: widget.controllerPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalization.of(context).translate('password_empty')!;
                      }
                      return null;
                    },
                    icon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    label: AppLocalization.of(context).translate('confirm_password')!,
                    controller: widget.controllerConfirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalization.of(context).translate('password_empty')!;
                      }
                      return null;
                    },
                    icon: Icons.lock_outline,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomStyledButton(
                          () {
                            if (_formKey.currentState!.validate()) {
                              // Handle form submission
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
      },
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
}
