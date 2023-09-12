import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../db/notes_database.dart';
import '../../model/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = false;
  String wifiIP ="";

  Future refreshNotes() async {
    isLoading = true;
    notes = await NotesDatabase.instance.readAllNotes();
    isLoading = false;
  }
  Future addNote(Note note) async {
    isLoading = true;
    note = note.copy(
      macAddress: "macaddress",
      ipAddress: wifiIP,
    );
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
// Check if Wi-Fi is available
  Future<void> checkWifiAvailability() async {
    checkNetworkConnectivity();
    final networkInfo = NetworkInfo();
    final wifiIPText = await networkInfo.getWifiIP();
    if (wifiIPText != null) {
      wifiIP=wifiIPText;
      print('Wi-Fi is available. IP: $wifiIPText');
    } else {
      print('Wi-Fi is not available.');
    }
  }

// Check network connectivity
  Future<void> checkNetworkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      print('Connected to Wi-Fi');
    } else if (connectivityResult == ConnectivityResult.mobile) {
      print('Connected to mobile data');
    } else {
      print('No network connection');
    }
  }

}
