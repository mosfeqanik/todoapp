import 'package:flutter/cupertino.dart';

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

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }
}
