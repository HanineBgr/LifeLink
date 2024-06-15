import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/register_doctor_page.dart';
import 'package:glumate_flutter/presentation/pages/register_patient_page.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/Design/text_form_widget.dart';

class roleWidget extends StatefulWidget {
  roleWidget({Key? key}) : super(key: key);

  @override
  _roleWidgetState createState() => _roleWidgetState();
}

class _roleWidgetState extends State<roleWidget> {
  int selectedRole = 1;
  final _formKey = GlobalKey<FormState>();

  Widget CustomRoleButton(String assetName, int index, String buttonText) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedRole = index;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (selectedRole == index) ? 2.0 : 0.5,
            color: (selectedRole == index) ? Colors.green : Colors.blue.shade600),
      ),
      child: Stack(
        children: [
          Container(
            width: 320,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    assetName,
                    fit: BoxFit.contain,
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 10),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selectedRole == index)
            Positioned(
              top: 5,
              right: 5,
              child: Image.asset(
                "assets/tick2.png",
                width: 30,
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
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 213, 235, 255),
                const Color.fromARGB(255, 248, 244, 246),
              ],
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent, 
              elevation: 0, 
            ),
            backgroundColor: Colors.transparent, 
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRoleButton(
                        "assets/patient.png",
                        1,
                        AppLocalization.of(context).translate('patient')!,
                      ),
                      SizedBox(height: 40),
                      CustomRoleButton(
                        "assets/doctor.png",
                        2,
                        AppLocalization.of(context).translate('care_provider')!,
                      ),
                      SizedBox(height: 25),
                      CustomStyledButton(() {
                        if (selectedRole == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPatientPage()),
                          );
                        } else if (selectedRole == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterDoctorPage()),
                          );
                        }
                      }, AppLocalization.of(context).translate('next')!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget CustomStyledButton(Function onPressed, String buttonText) {
    return SizedBox(
      width: 250,
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
