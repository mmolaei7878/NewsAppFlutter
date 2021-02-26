import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageProvider with ChangeNotifier {
  List languageCode = ["en", "ar"];
  List countryCode = ["US", "FA"];
  void changeLangunage({BuildContext context, int index}) {
    EasyLocalization.of(context).locale =
        Locale(languageCode[index], countryCode[index]);
    notifyListeners();
  }
}
