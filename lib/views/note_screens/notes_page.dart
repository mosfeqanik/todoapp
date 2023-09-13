import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
    // _noteProvider = Provider.of<NoteProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<NoteProvider>(context, listen: false).refreshNotes();
    // });
    // if (Provider.of<NoteProvider>(context, listen: false).notes.isEmpty) {
    //   showDialog();
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _noteProvider = Provider.of<NoteProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NoteProvider>(context, listen: false).refreshNotes();
    });

    if (Provider.of<NoteProvider>(context, listen: false).notes.isEmpty) {
      showDialog();
    }
  }

  void showDialog() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Alert(
        context: context,
        type: AlertType.info,
        title: "ALERT",
        desc: "You have no To-do",
        buttons: [
          DialogButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close the current dialog if needed
              await Future.delayed(
                  Duration.zero); // Wait for the build to complete
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddEditNotePage(),
                ),
              );
            },
            color: Colors.redAccent,
            radius: BorderRadius.circular(10.0),
            child: const Text(
              "Save your Notes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    });
  }

  @override
  void dispose() {
    Provider.of<NoteProvider>(context, listen: false).dispose();
    super.dispose();
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
          builder: (_, controller, ___) {
            return Center(
              child: controller.isLoading
                  ? const CircularProgressIndicator()
                  : controller.notes.isEmpty
                      ? const Text(
                          'No Notes',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )
                      : buildNotes(notes: controller.notes),
            );
          },
        ),
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
