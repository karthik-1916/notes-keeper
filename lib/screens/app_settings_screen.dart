import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';

class AppSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            settingCategory('Appearance'),
            setting(settingName: 'Dark Theme'),
            Divider(thickness: 1, color: Colors.black),
            settingCategory('Notification'),
            setting(settingName: 'Coming Soon', checkmarkEnabled: false)
          ],
        ),
      ),
    );
  }

  ///Setting Category Title
  ///
  Widget settingCategory(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, top: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 1.5,
          color: Colors.blue,
        ),
      ),
    );
  }

  ///Setting
  Widget setting({
    String settingName,
    bool checkmarkEnabled = true,
  }) {
    return Container(
      child: Row(
        children: <Widget>[
          Consumer<AppTheme>(
            builder: (context, notifier, child) => Expanded(
              child: checkmarkEnabled
                  ? SwitchListTile(
                      title: Text(settingName),
                      onChanged: (value) {
                        if (settingName == 'Dark Theme') {
                          notifier.toggleTheme();
                        }
                      },
                      value: notifier.darkTheme,
                    )
                  : Text(settingName),
            ),
          )
        ],
      ),
    );
  }
}
