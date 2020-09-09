import 'package:flutter/material.dart';
import 'package:notes_keeper/database/app_database.dart';
import 'color_picker_widget.dart';
import '../models/note.dart';

class NotesWidget extends StatefulWidget {
  final Note note;
  NotesWidget(this.note);

  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  bool _markAsDone;
  var dbHelper = AppDatabase();

  @override
  Widget build(BuildContext context) {
    _markAsDone = widget.note.markAsDone == 'true' ? true : false;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: colors[widget.note.color],
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          border: Border.all(width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.note.title.length != 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.note.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (widget.note.description.length != 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.note.description,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.note.createdDate,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            if (widget.note.reminder != null)
              if (DateTime.parse(widget.note.reminder).isBefore(DateTime.now()))
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print('object');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Mark As Done',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.black,
                        ),
                        child: Checkbox(
                          onChanged: (value) async {
                            widget.note.markAsDone = value.toString();
                            await dbHelper.updateNote(widget.note);
                            setState(() {});
                          },
                          value: _markAsDone,
                          activeColor: Colors.black,
                          hoverColor: Colors.black,
                          visualDensity: VisualDensity(vertical: 2.0),
                        ),
                      )
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
