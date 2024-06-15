
class Language {
  final int id;
  final String name;
  final String languageCode;
  final String flagImagePath;
  Language(this.id, this.name, this.languageCode , this.flagImagePath);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "English", "en", "assets/eng.png"),
      Language(2, "French", "fr", "assets/fr.png")
    ];
  }
}
