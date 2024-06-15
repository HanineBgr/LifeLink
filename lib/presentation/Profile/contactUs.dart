import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/Design/colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          AppLocalization.of(context).translate('contact')!,
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align content at the top
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90), // Adjusted padding here
              child: Image.asset(
                "assets/contact.png",
                fit: BoxFit.contain,
                width: 300,
                height: 250,
              ),
            ),
            SizedBox(height: 20), // Added SizedBox for spacing
            Text(
              AppLocalization.of(context).translate('info')!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomRoleButton(
                email: 'GluMate@gmail.com',
                phone: '+21655668192',
                link: 'www.GluMate.com',
                iconColor: Color.fromARGB(255, 161, 203, 237),
                textColor: Color.fromARGB(255, 44, 106, 154),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRoleButton extends StatelessWidget {
  final String phone;
  final String email;
  final String link;
  final Color iconColor;
  final Color textColor;

  const CustomRoleButton({
    required this.phone,
    required this.email,
    required this.link,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContactInfoRow(icon: Icons.email, text: email, iconColor: iconColor, textColor: textColor),
        ContactInfoRow(icon: Icons.phone, text: phone, iconColor: iconColor, textColor: textColor),
        ContactInfoRow(icon: Icons.link, text: link, iconColor: iconColor, textColor: textColor),
      ],
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;

  const ContactInfoRow({
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor), // Apply icon color
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor, 
            ),
          ),
        ],
      ),
    );
  }
}
