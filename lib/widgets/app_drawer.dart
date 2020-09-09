import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_keeper/screens/notes_home_screen.dart';
import '../screens/app_settings_screen.dart';

///Custom AppDrawer.
///
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.all(8.0),
        children: <Widget>[
          //Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).accentColor),
            child: Center(
              child: Text(
                'Notes Keeper',
                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 24)),
              ),
            ),
          ),
          _buildDrawerListTile(
            'Notes',
            Icons.note,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotesHomeScreen('All Notes');
                  },
                ),
              );
            },
          ),
          _buildDrawerListTile(
            'Reminder',
            Icons.add_alert,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotesHomeScreen('Reminder');
                  },
                ),
              );
            },
          ),
          _buildDrawerListTile(
            'Archive',
            Icons.archive,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotesHomeScreen('Archive');
                  },
                ),
              );
            },
          ),
          _buildDrawerListTile(
            'Trash',
            Icons.delete,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotesHomeScreen('Trash');
                  },
                ),
              );
            },
          ),
          Divider(
            color: Colors.black,
          ),
          _buildDrawerListTile(
            'Settings',
            Icons.settings,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AppSettingsScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ///Function to build drawer List tiles.
  ///
  ///[title] is title of the list item.
  ///
  ///[icon] is the leading icon for the list item.
  ///
  ///[onTap] is the function called when the a list item is tapped.
  ///
  Widget _buildDrawerListTile(String title, IconData icon, Function onTap) {
    return ListTile(
      contentPadding: EdgeInsets.all(12.0),
      dense: true,
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),
      onTap: onTap,
    );
  }
}
