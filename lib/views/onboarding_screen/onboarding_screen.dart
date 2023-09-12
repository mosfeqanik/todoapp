import 'package:flutter/material.dart';

import '../../utils/local_storage_manager.dart';
import '../../utils/shared_pref_keys.dart';
import '../../widget/custom_button.dart';
import '../note_screens/notes_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Hero(
              tag: 'keep',
              child: Icon(
                Icons.edit_note_sharp,
                size: 120,
                color: Colors.deepPurple[900],
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Hero(
            tag: 'Note',
            child: Text(
              'Converse',
              style: TextStyle(
                  color: Colors.deepPurple[900],
                  fontFamily: 'Poppins',
                  fontSize: 26,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
          CustomButton(
            onpress: () async {
              LocalStorageManager.saveData(
                  SharedPrefStrings.isOnboardingShowed, true);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotesPage(),
                ),
              );
            },
            text: 'Next',
            accentColor: Colors.white,
            mainColor: Colors.deepPurple,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
