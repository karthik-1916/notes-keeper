class Note {
  int id;
  String title;
  String description;
  String createdDate;
  int color;
  String lastEdited;
  String reminder;
  String trashed;
  String archived;
  String markAsDone;

  Note({
    this.id,
    this.title,
    this.description,
    this.createdDate,
    this.color,
    this.lastEdited,
    this.reminder,
    this.trashed = 'false',
    this.archived = 'false',
    this.markAsDone = 'false',
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['description'] = description;
    map['color'] = color;
    map['createdDate'] = createdDate;
    map['lastEdited'] = lastEdited;
    map['reminder'] = reminder;
    map['trashed'] = trashed;
    map['archived'] = archived;
    map['markAsDone'] = markAsDone;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.createdDate = map['createdDate'];
    this.color = map['color'];
    this.lastEdited = map['lastEdited'];
    this.reminder = map['reminder'];
    this.trashed = map['trashed'];
    this.archived = map['archived'];
    this.markAsDone = map['markAsDone'];
  }
}
