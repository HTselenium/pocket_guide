import 'package:flutter/material.dart';
// TODO(someone): use for data privacy translation
/// {@template language}
/// Currently supported languages as an enum
/// {@endtemplate}
enum Languages {
  english('🇺🇸 English', Locale('en'));


  // Uncomment needed ones
  // ❗ Remember to update the ';' on top for a ','
  // ❗ And add a ';' to the newly added one, as last one

  /*
  this one got put on hold because of hiding language settings
  spanish('🇪🇸 Español', Locale('es'));
  -------------------------------------
  german('🇩🇪 Deutsch', Locale('de')),
  arabic('🇦🇪 عربى', Locale('ar')),
  azerbaijani('🇦🇿 Azərbaycanca', Locale('az')),
  bulgarian('🇧🇬 български', Locale('bg')),
  montenegrin('🇲🇪 Crnogorski', Locale('cnr')),
  danish('🇩🇰 Dansk', Locale('da')),
  greek('🇬🇷 Ελληνικά', Locale('el')),
  estonian('🇪🇪 Eesti', Locale('et')),
  persian('🇮🇷 فارسی', Locale('fa')),
  french('🇫🇷 Français', Locale('fr')),
  hebrew('🇮🇱 עברית', Locale('he')),
  croatian('🇭🇷 Hrvatski', Locale('hr')),
  armenian('🇦🇲 հայերեն', Locale('hy')),
  icelandic('🇮🇸 Íslenska', Locale('is')),
  italian('🇮🇹 Italiano', Locale('it')),
  japanese('🇯🇵 日本語', Locale('ja')),
  georgian('🇬🇪 ქართველი', Locale('ka')),
  korean('🇰🇷 한국어', Locale('ko')),
  lithuanian('🇱🇹 Lietuvių', Locale('lt')),
  latvian('🇱🇻 Latviešu', Locale('lv')),
  macedonian('🇲🇰 македонски', Locale('mk')),
  dutch('🇳🇱 Nederlands', Locale('nl')),
  norwegian('🇳🇴 Norsk bokmål', Locale('no')),
  polish('🇵🇱 Polski', Locale('pl')),
  portuguese('🇵🇹 Português', Locale('pt')),
  romanian('🇷🇴 Română', Locale('ro')),
  russian('🇷🇺 Pусский', Locale('ru')),
  slovak('🇸🇰 Slovák', Locale('sk')),
  albanian('🇦🇱 Shqip', Locale('sq')),
  serbian('🇷🇸 Cрпски', Locale('sr')),
  swedish('🇸🇪 Svenska', Locale('sv')),
  turkmen('🇹🇲 Türkmenler', Locale('tk')),
  turkish('🇹🇷 Türkçe', Locale('tr')),
  uzbek("🇺🇿 O'zbek", Locale('uz')),
  chinese('🇨🇳 中文', Locale('zh'));
  */

  /// {@macro language}
  const Languages(this.text, this.locale);

  /// String representation of the language
  final String text;

  /// Locale of the language
  final Locale locale;

  /// List of all languages
  static List<Languages> get all => values;
}
