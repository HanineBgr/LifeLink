import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/core/localization/language.dart';

class LanguageView extends StatelessWidget {
  final Function(Locale) onLocaleChanged;

  LanguageView(this.onLocaleChanged);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalization.of(context).translate('language')!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: Language.languageList().map((language) {
          return ListTile(
            leading: Image.asset(
              language.flagImagePath,
              width: 30, 
              height: 30, 
            ),
            title: Text(
              language.name,
              style: TextStyle(fontSize: 20),
            ),
            onTap: () async {
              final newLocale = Locale(language.languageCode);
              onLocaleChanged(newLocale);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}