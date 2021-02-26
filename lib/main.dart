import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/Providers/NewsProvider.dart';
import 'package:flutter_music/Providers/languageProvider.dart';
import 'Screens/SettingScreen.dart';
import 'Screens/SavesListScreen.dart';
import 'package:provider/provider.dart';
import 'Screens/DescriptionsScreen.dart';
import 'Screens/NewsScreen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'Screens/DescriptionsSaverScreen.dart';

void main() {
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'FA')],
      path: 'assets/translation',
      fallbackLocale: Locale('en', 'US'),
      saveLocale: true,
      child: Phoenix(child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NewsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LanguageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: NewsScreen(),
        routes: {
          SavesListScreen.routeNamed: (ctx) => SavesListScreen(),
          NewsScreen.routeNamed: (ctx) => NewsScreen(),
          DescriptionsScreen.routeNamed: (ctx) => DescriptionsScreen(),
          DescriptionsSaverScreen.routeNamed: (ctx) =>
              DescriptionsSaverScreen(),
          SettingScreen.routeNamed: (ctx) => SettingScreen(),
        },
      ),
    );
  }
}
