import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import '../../provider/note/note_provider.dart';
import '../../widget/note_card_widget.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late NoteProvider _noteProvider;
  @override
  void initState() {
    super.initState();
    _noteProvider = Provider.of<NoteProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _noteProvider.refreshNotes();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Consumer<NoteProvider>(
            builder: (_, controller, ___) => Center(
                  child: controller.isLoading
                      ? const CircularProgressIndicator()
                      : controller.notes.isEmpty
                          ? const Text(
                              'No Notes',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )
                          : buildNotes(notes: controller.notes),
                )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddEditNotePage(),
              ),
            );
            _noteProvider.refreshNotes();
          },
        ),
      );

  Widget buildNotes({required List<Note> notes}) => ListView.builder(
        itemCount: notes.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: note.id!),
                ),
              );
              _noteProvider.refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
