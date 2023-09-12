import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../db/notes_database.dart';
import '../../model/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = false;

  Future refreshNotes() async {
    isLoading = true;
    notes = await NotesDatabase.instance.readAllNotes();
    isLoading = false;
  }
  Future addNote(Note note) async {
    isLoading = true;
    await NotesDatabase.instance.create(note);
    isLoading = false;
  }
  Future updateNote(Note note) async {
    isLoading = true;
         await NotesDatabase.instance.update(note);
    isLoading = false;
  }


  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }
}
