
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/Design/text_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';

class registerDoctorForm1 extends StatefulWidget {

   final TextEditingController controllerName;
   final TextEditingController controllerLastName;
   final TextEditingController controllerEmail;
   final TextEditingController controllerPhone;



   final VoidCallback? onNextPressed ;

  registerDoctorForm1({
    Key? key,
    required this.controllerName,
    required this.controllerLastName,
    required this.controllerEmail,
    required this.controllerPhone,
    this.onNextPressed
   
  }) : super(key: key);

  @override
  _registerForm1State createState() => _registerForm1State();


}


class _registerForm1State extends State<registerDoctorForm1> {
 RegExp get _emailRegex =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
   
    final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context){
     return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
  return Form(
    key: _formKey,
    child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                top: 0,
                left: 28,
                right: 28,
              ),
                child: Column(
                children: [
                  Image.asset("assets/subscribe.png",
                  height: 220,
                  width:420,),
             CustomTextFormField(
            label :   AppLocalization.of(context).translate('first_name')!,
            controller : widget.controllerName ,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return AppLocalization.of(context).translate('first_name_empty')!;
              } else {
                if (value.length<3) {
                  return AppLocalization.of(context).translate('first_name_error')!;
                }
              }
              return null;
            },
                          icon: Icons.person,

          ),
            const SizedBox(height: 18), 

                CustomTextFormField(
            label :   AppLocalization.of(context).translate('last_name')!,
            controller : widget.controllerLastName ,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return AppLocalization.of(context).translate('last_name_empty')!;
              } else {
                if (value.length<3) {
                  return AppLocalization.of(context).translate('last_name_error')!;
                }
              }
              return null;
            },
              icon: Icons.person,

          ),
          const SizedBox(height: 20,),
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
     

                     const SizedBox(height: 20,),
                   CustomTextFormField(
  label: AppLocalization.of(context).translate('phone')!,
  controller: widget.controllerPhone,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context).translate('phone_error')!;
    } else if (value.length != 8) {
      return AppLocalization.of(context).translate('phone_error')!;
    } else if (!RegExp(r'^[2594]').hasMatch(value)) {
      return AppLocalization.of(context).translate('phone_error')!;
    }
    return null;
  },
  icon: Icons.phone,
),
const SizedBox(height: 20),


                   Center( 
                    child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomStyledButton(
                          () {
                            if (_formKey.currentState!.validate()) {
                              widget.onNextPressed!();
                            }
                          },
                          AppLocalization.of(context).translate('next')!,
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


