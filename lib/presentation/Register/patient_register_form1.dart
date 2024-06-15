import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/Design/text_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';

class registerForm1 extends StatefulWidget {
  final TextEditingController controllerName;
  final TextEditingController controllerLastName;
  int selectedGender = 1;
  final void Function(int, DateTime) onNextPressed;
  DateTime selectedDate = DateTime.now();

  registerForm1({
    Key? key,
    required this.controllerName,
    required this.controllerLastName,
    required this.selectedGender,
    required this.selectedDate,
    required this.onNextPressed,
  }) : super(key: key);

  @override
  _registerForm1State createState() => _registerForm1State();
}

class _registerForm1State extends State<registerForm1> {
  int selectedGender = 1;
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  Widget CustomGenderButton(String assetName, int index, String buttonText) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedGender = index;
          widget.selectedGender = selectedGender;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
          width: (selectedGender == index) ? 2.0 : 0.5,
          color: (selectedGender == index) ? Colors.green : Colors.blue.shade600,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  assetName,
                  fit: BoxFit.contain,
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 5),
                Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (selectedGender == index)
            Positioned(
              top: 5,
              right: 5,
              child: Image.asset(
                "assets/tick2.png",
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
        return Scaffold(
          backgroundColor: Colors.transparent, // Transparent scaffold background
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 213, 235, 255),
                  Color.fromARGB(255, 248, 244, 246),
                ],
              ),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 0,
                    left: 28,
                    right: 28,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  height: MediaQuery.of(context).size.height, // Adjusted height
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/subscribe.png",
                        height: 220,
                        width: 450,
                      ),
                      CustomTextFormField(
                        label: AppLocalization.of(context).translate('first_name')!,
                        controller: widget.controllerName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalization.of(context).translate('first_name_empty')!;
                          } else {
                            if (value.length < 3) {
                              return AppLocalization.of(context).translate('first_name_error')!;
                            }
                          }
                          return null;
                        },
                        icon:Icons.person ,
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        label: AppLocalization.of(context).translate('last_name')!,
                        controller: widget.controllerLastName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalization.of(context).translate('last_name_empty')!;
                          } else {
                            if (value.length < 3) {
                              return AppLocalization.of(context).translate('last_name_error')!;
                            }
                          }
                          return null;
                        },
                        icon:Icons.person ,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomGenderButton("assets/male.png", 1, AppLocalization.of(context).translate('male')!),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomGenderButton("assets/female.png", 2, AppLocalization.of(context).translate('female')!),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, color: const Color.fromARGB(255, 118, 183, 221),),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            child: Text(AppLocalization.of(context).translate('select_DOB')!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(height: 15),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomStyledButton(
                              () {
                                if (_formKey.currentState!.validate()) {
                                  widget.onNextPressed(selectedGender, _selectedDate);
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1910),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.selectedDate = _selectedDate;
        print(widget.selectedDate);
      });
    }
  }
}
