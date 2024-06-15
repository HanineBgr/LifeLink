import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/pages/login_page.dart';
import 'package:glumate_flutter/presentation/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/Design/colors.dart';
import 'package:glumate_flutter/presentation/Profile/EditProfile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  int _currentPageIndex = 0;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
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
    Widget currentPage = EditProfile(
      controllerName: _controllerName,
      controllerEmail: _controllerEmail,
      controllerLastName: _controllerLastName,
      selectedDate: _selectedDate,
      onNextPressed: (selectedGender, selectedDate) async {
        setState(() {
          _selectedGender = selectedGender;
          _selectedDate = selectedDate;
        });

        final cachedUser =
            Provider.of<RegisterAuthProvider>(context, listen: false).cachedUser;
        if (cachedUser != null) {
          // Update user information
          await Provider.of<RegisterAuthProvider>(context, listen: false)
              .eitherFailureOrUpdateUser(
            id: cachedUser.id,
            updatedUserData: {
              'firstName': _controllerName.text,
              'lastName': _controllerLastName.text,
              'email': _controllerEmail.text,
              'dob': _selectedDate,
            },
          );

          // Trigger UI update
          setState(() {});
        }

        nextPage();
      },
      onFinish: () {},
    );

    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalization.of(context).translate('update')!,
              style: TextStyle(
                color: TColor.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: currentPage,
        );
      },
    );
  }
}
