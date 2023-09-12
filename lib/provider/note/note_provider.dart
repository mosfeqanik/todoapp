import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_mac_address/get_mac_address.dart';

import '../../db/notes_database.dart';
import '../../model/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = false;
  String _macAddress = 'Unknown';
  final _getMacAddressPlugin = GetMacAddress();
  Future refreshNotes() async {
    isLoading = true;
    notes = await NotesDatabase.instance.readAllNotes();
    isLoading = false;
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String macAddress;

    try {
      macAddress =
          await _getMacAddressPlugin.getMacAddress() ?? 'Unknown mac address';
      print(macAddress);
    } on PlatformException {
      macAddress = 'Failed to get mac address.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    _macAddress = macAddress;
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }
}
