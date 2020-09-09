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
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                'Appearence',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.5,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Consumer<AppTheme>(
                    builder: (context, notifier, child) => Expanded(
                      child: SwitchListTile(
                        title: Text('Dark Theme'),
                        onChanged: (value) {
                          notifier.toggleTheme();
                        },
                        value: notifier.darkTheme,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showThemeSelectorDialog(BuildContext context, AppTheme appTheme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Theme'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          content: Column(
            children: <Widget>[
              FlatButton(
                child: Text('Dark'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('Light'),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
