import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqflite.dart';
import '../widgets/scaffold_wrapper_widget.dart';
import '../widgets/app_drawer.dart';
import '../models/note.dart';
import '../database/app_database.dart';
import '../utils/app_settings.dart';
import '../widgets/notes_widget.dart';
import '../widgets/snackbar.dart';
import './note_details_screen.dart';

class NotesHomeScreen extends StatefulWidget {
  final appBarTitle;

  NotesHomeScreen(this.appBarTitle);

  @override
  _NotesHomeScreenState createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  List<Note> notesList;
  int notesListCount = 0;
  final dbHelper = AppDatabase();
  AppSettings settings = AppSettings();

  //Build Method
  @override
  Widget build(BuildContext context) {
    if (notesList == null) {
      notesList = List<Note>();
    }
    _updateNoteList();
    return ScaffoldWrapperWidget(
      drawer: AppDrawer(),
      appBar: appBar,
      body: notesListCount == 0
          ? Container(
              child: Center(
                child: Text('You Don\'t have any note Add One'),
              ),
            )
          : settings.showAsGridView ? getNotesGridView() : getNotesListView(),
      floatingActionButton: floatingActionButton(),
    );
  }

  ///Getter for Appbar
  ///
  Widget get appBar {
    return AppBar(
      titleSpacing: 1,
      title: Text(
        widget.appBarTitle,
      ),
      actions: <Widget>[
        settings.showAsGridView
            ? notesViewTypeIcon(
                Icon(
                  Icons.list,
                ),
                'show As List View')
            : notesViewTypeIcon(
                Icon(
                  Icons.grid_on,
                ),
                'show As Grid View'),
        settings.showListByValue == 0
            ? settings.sortByAsc
                ? sortingIcon(
                    Icon(FontAwesome.sort_alpha_desc), 'Sort Descending')
                : sortingIcon(
                    Icon(FontAwesome.sort_alpha_asc), 'Sort Ascending')
            : settings.sortByAsc
                ? sortingIcon(
                    Icon(FontAwesome.sort_numeric_desc), 'Sort Descending')
                : sortingIcon(
                    Icon(FontAwesome.sort_numeric_asc), 'Sort Ascending'),
        if (widget.appBarTitle != 'Reminder') buildDropDownButton,
      ],
    );
  }

  ///Draws grid or list icon depending on showAsGridValue.
  ///
  ///[icon] Icon to draw.
  ///
  ///[tootip] String.
  ///
  ///Returns IconButton Widget.
  ///
  Widget notesViewTypeIcon(Widget icon, String tooltip) {
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: () {
        setState(() {
          settings.toggleShowAsGrid();
        });
      },
    );
  }

  ///Draws sorting icon depending on showListByValue
  ///
  ///Draw sort_alpha icon if showListBy value is 0
  ///
  ///Otherwise draws sort_numeric icon.
  ///
  ///Return IconButton Widget.
  Widget sortingIcon(Widget icon, String tooltip) {
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: () {
        setState(() {
          settings.toggleSortByAsc();
          _updateNoteList();
        });
      },
    );
  }

  Widget get buildDropDownButton => DropdownButtonHideUnderline(
        child: DropdownButton(
          value: settings.showListByValue,
          items: [
            DropdownMenuItem(
              child: Text('Title'),
              value: 0,
            ),
            DropdownMenuItem(
              child: Text('Created Date'),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text('Last Edited'),
              value: 2,
            ),
          ],
          onChanged: (value) {
            setState(() {
              settings.changeShowListByValue(value);
              _updateNoteList();
            });
          },
          icon: Icon(FontAwesome.sort),
          hint: Text('Show List By'),
        ),
      );

  ///Return all the notes as Staggered Grid View.
  ///
  Widget getNotesGridView() {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: notesListCount,
      itemBuilder: (ctx, int index) => GestureDetector(
        onTap: () {
          moveToNoteDetailsScreen(index, ctx);
        },
        child: NotesWidget(notesList[index]),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  ///Return all the notes as List View.
  ///
  Widget getNotesListView() {
    return ListView.builder(
      itemCount: notesListCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              moveToNoteDetailsScreen(index, context);
            },
            child: NotesWidget(notesList[index]),
          ),
        );
      },
    );
  }

  ///Floating action button
  ///
  ///Return Floating action button.
  Widget floatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {
          print(DateTime.now().toString());
          moveToNoteDetailsScreen(-1, context);
        },
        tooltip: 'Add Note',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  ///Moves to the notes edit screen or add edit screen.
  ///
  void moveToNoteDetailsScreen(int index, BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => index == -1
            ? NoteDetailsScreen(
                note: Note(
                  title: '',
                  description: '',
                  color: 0,
                ),
                appBarTitle: 'Add Note',
              )
            : NoteDetailsScreen(
                note: notesList[index],
                appBarTitle: 'Edit Note',
              ),
      ),
    );
    if (result == 'true') {
      _updateNoteList();
    } else if (result == 'false') {
      showSnackBar(context, 'Empty Note Can\'t be Saved');
    } else if (result == 'trashed') {
      showSnackBar(context, 'Note added to trash');
    } else if (result == 'archived') {
      showSnackBar(context, 'Note Archived');
    } else if (result == 'deleted') {
      showSnackBar(context, 'Note Deleted Permanently');
      _updateNoteList();
    }
  }

  ///Update the notesList on successfull note save.
  ///
  _updateNoteList() {
    String queryString;
    if (widget.appBarTitle == 'All Notes') {
      queryString = allNotesQuery[settings.showListByValue];
    } else if (widget.appBarTitle == 'Reminder') {
      queryString = reminderQuery;
    } else if (widget.appBarTitle == 'Trash') {
      queryString = trashQuery[settings.showListByValue];
    } else {
      queryString = archivedQuery[settings.showListByValue];
    }
    final Future<Database> dbFuture = dbHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = dbHelper.getNotesList(queryString);
      noteListFuture.then((noteList) {
        if (mounted)
          setState(() {
            this.notesList =
                settings.sortByAsc ? noteList : noteList.reversed.toList();
            this.notesListCount = noteList.length;
          });
      });
    });
  }
}
