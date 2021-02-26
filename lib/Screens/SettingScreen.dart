import 'package:flutter/material.dart';
import '../Providers/languageProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingScreen extends StatefulWidget {
  static const routeNamed = 'SettingScreen';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("${("language".tr().toString())}"),
            trailing: DropdownButton(
              onChanged: (_) {
                Phoenix.rebirth(context);
              },
              items: [
                DropdownMenuItem(
                    onTap: () {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLangunage(context: context, index: 1);
                    },
                    child: Text('فارسی')),
                DropdownMenuItem(
                    onTap: () {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLangunage(context: context, index: 0);
                    },
                    child: (Text('ENGLISH')))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
