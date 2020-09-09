import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';

final List<String> allNotesQuery = [
  'SELECT * FROM node_table WHERE archived IS \'false\' AND trashed IS \'false\' ORDER BY title',
  'SELECT * FROM node_table WHERE archived IS \'false\' AND trashed IS \'false\' ORDER BY createdDate',
  'SELECT * FROM node_table WHERE archived IS \'false\' AND trashed IS \'false\' ORDER BY lastEdited',
];

final String reminderQuery =
    'SELECT * FROM node_table WHERE reminder IS NOT NULL AND trashed IS \'false\' AND archived IS \'false\' ORDER BY reminder DESC';

final List<String> trashQuery = [
  'SELECT * FROM node_table WHERE trashed IS \'true\'',
  'SELECT * FROM node_table WHERE trashed IS \'true\' ORDER BY createdDate',
  'SELECT * FROM node_table WHERE trashed IS \'true\' ORDER BY lastEdited'
];

final List<String> archivedQuery = [
  'SELECT * FROM node_table WHERE archived IS \'true\' AND trashed IS \'false\'',
  'SELECT * FROM node_table WHERE archived IS \'true\' AND trashed IS \'false\' ORDER BY createdDate',
  'SELECT * FROM node_table WHERE archived IS \'true\' AND trashed IS \'false\' ORDER BY lastEdited',
];

class AppDatabase {
  static AppDatabase _appDatabase;
  static Database _database;

  final String noteTable = 'node_table';
  final String id = 'id';
  final String title = 'title';
  final String description = 'description';
  final String color = 'color';
  final String createdDate = 'createdDate';
  final String lastEdited = 'lastEdited';
  final String reminder = 'reminder';
  final String trashed = 'trashed';
  final String archived = 'archived';
  final String markAsDone = 'markAsDone';

  AppDatabase._createInstance();

  factory AppDatabase() {
    if (_appDatabase == null) {
      _appDatabase = AppDatabase._createInstance();
    }
    return _appDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  ///Initializes and Returns the database.
  ///
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  ///Creates the database.
  ///
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, '
        '$description TEXT, $color INTEGER,$createdDate TEXT, $lastEdited TEXT, $reminder TEXT, $trashed TEXT, $archived TEXT, $markAsDone TEXT)');
  }

  ///Gets all the notes and returns the result as List of map.
  ///
  ///[query] is the query string to be excecuted.
  ///
  Future<List<Map<String, dynamic>>> getAllNotes(String query) async {
    var db = await this.database;
    // var result = await db.query(noteTable);
    var result = await db.rawQuery(query);
    return result;
  }

  ///Inserts a note to the database.
  ///
  ///[note] is the note to be inserted.
  ///
  ///Returns the id of the note on Successfull insertion.
  ///
  Future<int> insertOne(Note note) async {
    var db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  ///Updates the existing note.
  ///
  ///[note] is the note to be updated.
  ///
  ///Returns the id of the note on successful update.
  ///
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(
      noteTable,
      note.toMap(),
      where: '$id = ?',
      whereArgs: [note.id],
    );
    return result;
  }

  Future<int> getSingleNote(Note note) async {
    var db = await this.database;
    var result = await db.query(noteTable, where: '$id = ?', whereArgs: [note.id]);
  }

  ///Deletes the note.
  ///
  ///[noteId] is the id of the note to be deleted.
  ///
  ///Returns noteID on successful deletion.
  ///
  Future<int> deleteNote(int noteId) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $id = $noteId');
    return result;
  }

  ///Gets the notes and return the List<Note>.
  ///
  ///[query] is the query to be excecuted to get the notes.
  ///
  ///Returns the List<Note>.
  Future<List<Note>> getNotesList(String query) async {
    var notesMapList = await getAllNotes(query);
    int count = notesMapList.length;

    List<Note> noteList = List<Note>();

    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(notesMapList[i]));
    }
    return noteList;
  }
}
